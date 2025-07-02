//
//  CoreDataManager.swift
//  Setara
//
//  Created by Patrick Samuel Owen Saritua Sinaga on 09/02/25.
//

import Combine
import CoreData

class CoreDataManager {
  static let shared = CoreDataManager()
  
  lazy var persistentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "item")
    let description = container.persistentStoreDescriptions.first
    description?.shouldMigrateStoreAutomatically = true
    description?.shouldInferMappingModelAutomatically = true
    container.loadPersistentStores { _, error in
      if let error = error as? NSError {
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    }
    return container
  }()
  
  var context: NSManagedObjectContext {
    return persistentContainer.viewContext
  }
  
  func saveContext() -> AnyPublisher<Bool, Error> {
    let context = persistentContainer.viewContext
    return Future<Bool, Error> { promise in
      if context.hasChanges {
        do {
          try context.save()
          promise(.success(true))
        } catch {
          context.rollback()
          promise(.failure(error))
        }
      } else {
        promise(.success(false))
      }
    }
    .mapError { error in
      return CoreDataError.saveFailed(error.localizedDescription)
    }
    .eraseToAnyPublisher()
  }
  
  func addOrUpdateEntity<T: NSManagedObject>(predicate: NSPredicate, updateHandler: @escaping (T) -> Void) ->  AnyPublisher<Bool, Error> {
    return Future<Bool, Error> { [weak self] promise in
      guard let self = self else { return }
      
      let fetchRequest = NSFetchRequest<T>(entityName: String(describing: T.self))
      fetchRequest.predicate = predicate
      
      do {
        let results = try context.fetch(fetchRequest)
        
        if let existingEntity = results.first {
          updateHandler(existingEntity)
        } else {
          let newEntity = T(context: self.context)
          updateHandler(newEntity)
        }
        
        try self.context.save()
        promise(.success(true))
        
      } catch {
        self.context.rollback()
        promise(.failure(error))
      }
    }
    .mapError { error in
      return CoreDataError.saveFailed(error.localizedDescription)
    }
    .eraseToAnyPublisher()
  }
}
