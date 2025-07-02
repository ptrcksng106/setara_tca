//
//  CoreDataError.swift
//  Setara
//
//  Created by Patrick Samuel Owen Saritua Sinaga on 09/02/25.
//

import Foundation

enum CoreDataError: LocalizedError {
  case saveFailed(String)
  
  var errorDescription: String? {
    switch self {
    case .saveFailed(let message):
      return "Failed to save Core Data context: \(message)"
    }
  }
}
