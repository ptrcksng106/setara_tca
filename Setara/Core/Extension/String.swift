//
//  String.swift
//  Setara
//
//  Created by Patrick Samuel Owen Saritua Sinaga on 09/02/25.
//

import Foundation

extension String {
  public var localized: String {
    return NSLocalizedString(self, tableName: nil, bundle: .main, value: "", comment: "")
  }
}
