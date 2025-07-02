//
//  AddBillReducer.swift
//  Setara
//
//  Created by Patrick Samuel Owen Saritua Sinaga on 09/02/25.
//

import ComposableArchitecture
import SwiftUI

@Reducer
struct AddBillReducer: Reducer {
  enum Action {
    case addBillTapped
    case doneTapped
    case presentNavigation(presented: Bool)
    case toggleBottomsheet(isShowed: Bool)
  }
  
  enum SelectedDestination: Equatable {
    case summary
  }
  
  struct State: Equatable {
    var isPresented: Bool = false
    var isShowBottomsheet = false
  }
  
  var body: some ReducerOf<AddBillReducer> {
    Reduce { state, action in
      switch action {
      case .addBillTapped:
        state.isShowBottomsheet = true
        return .none
        
      case .doneTapped:
        return .none
        
      case .presentNavigation(let presented):
        state.isPresented = presented
        return.none
        
      case .toggleBottomsheet(let isShowwed):
        state.isShowBottomsheet = isShowwed
        return .none
      }
    }
  }
}
