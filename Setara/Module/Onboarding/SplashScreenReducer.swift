//
//  SplashScreenReducer.swift
//  Setara
//
//  Created by Patrick Samuel Owen Saritua Sinaga on 08/02/25.
//

import ComposableArchitecture
import SwiftUI

@Reducer
struct SplashScreenReducer: Reducer {
  enum Action {
    case navigateToHome
    case presentNavigation(presented: Bool)
  }
  
  struct State: Equatable {
    var isPresentNavigation: Bool = false
    var selectedDestination: ScreenDestination?
  }
  
  enum ScreenDestination: Equatable {
    case home(store: StoreOf<HomeReducer>)
  }
  
  var body: some ReducerOf<SplashScreenReducer> {
    Reduce { state, action in
      switch action {
      case .navigateToHome:
        let homeStore = Store(initialState: HomeReducer.State(), reducer: { HomeReducer() })
        state.selectedDestination = .home(store: homeStore)
        state.isPresentNavigation = true
        return .none
      case .presentNavigation(let presented):
        state.isPresentNavigation = presented
        return .none
      }
    }
  }
}
