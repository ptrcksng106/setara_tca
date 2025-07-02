//
//  AddBillUseCase.swift
//  Setara
//
//  Created by Patrick Samuel Owen Saritua Sinaga on 09/02/25.
//

import Combine
import Dependencies
import Foundation

internal struct AddBillUseCase {
  var saveItem: (_ id: String,_ itemName: String,_ participant: String,_ date: Date,_ total: Int16) -> AnyPublisher<Bool, Error>
}

extension AddBillUseCase {
  internal static var item: Self {
    let coreDataManager = CoreDataManager.shared
    
    return Self(
      saveItem: { (id: String, itemName: String, participant: String, date: Date, total: Int16) in
        coreDataManager.addOrUpdateEntity(predicate: NSPredicate(format: "id == %@", id)) { (item: ItemEntity) in
          item.id = id
          item.itemName = itemName
          item.participant = participant
          item.date = date
          item.total = total
        }
      }
    )
  }
}

extension AddBillUseCase: DependencyKey {
  internal static let liveValue = AddBillUseCase.item
}

extension DependencyValues {
  internal var addBillUseCase: AddBillUseCase {
    get { self[AddBillUseCase.self] }
    set { self[AddBillUseCase.self] = newValue }
  }
}
