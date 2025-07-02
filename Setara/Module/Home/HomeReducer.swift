//
//  HomeReducer.swift
//  Setara
//
//  Created by Patrick Samuel Owen Saritua Sinaga on 08/02/25.
//

import ComposableArchitecture
import SwiftUI

@Reducer
struct HomeReducer: Reducer {
  enum Action {
    case addNewbillTapped
    case detailCardTapped
    case presentNavigation(presented: Bool)
  }
  
  struct State: Equatable {
    var isPresentNavigation: Bool = false
    var selectedDestination: ScreenDestination?
  }
  
  enum ScreenDestination: Equatable {
    case addNewBill(store: StoreOf<AddBillReducer>)
  }
  
  var body: some ReducerOf<HomeReducer> {
    Reduce { state, action in
      switch action {
      case .addNewbillTapped:
        let store = Store(initialState: AddBillReducer.State(), reducer: { AddBillReducer() })
        state.selectedDestination = .addNewBill(store: store)
        state.isPresentNavigation = true
        return .none
      case .detailCardTapped:
        return .none
      case .presentNavigation(let presented):
        state.isPresentNavigation = presented
        return .none
      }
    }
  }
}
