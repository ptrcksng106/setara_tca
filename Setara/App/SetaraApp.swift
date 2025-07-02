//
//  SetaraApp.swift
//  Setara
//
//  Created by Patrick Samuel Owen Saritua Sinaga on 08/02/25.
//

import ComposableArchitecture
import SwiftUI

@main
struct SetaraApp: App {
  let store = Store(
      initialState: SplashScreenReducer.State(),
      reducer: { SplashScreenReducer() }
    )
  
  var body: some Scene {
    WindowGroup {
      NavigationView {
        SplashScreenView(store: store)
      }
    }
  }
}
