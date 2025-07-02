//
//  SplashScreenView.swift
//  Setara
//
//  Created by Patrick Samuel Owen Saritua Sinaga on 08/02/25.
//

import ComposableArchitecture
import Lottie
import SwiftUI

struct SplashScreenView: View {
  let store: StoreOf<SplashScreenReducer>
  
  var body: some View {
    WithViewStore(self.store, observe: { $0 }) { viewStore in
      ZStack {
        NavigationLink(
          isActive: viewStore.binding(
            get: \.isPresentNavigation,
            send: {
              SplashScreenReducer.Action.presentNavigation(presented: $0)
            }
          ),
          destination: {
            switch viewStore.selectedDestination {
            case .home(let store):
              HomeView(store: store)
            default:
              EmptyView()
            }
          },
          label: {
            EmptyView()
          }
        )
        
        LottieView {
          try await DotLottieFile.named("splashscreen")
        } placeholder: {
          Color.black
        }
        .configure { view in
          view.contentMode = .scaleToFill
          view.shouldRasterizeWhenIdle = true
        }
        .playing(loopMode: .autoReverse)
        .ignoresSafeArea()
      }
      .onAppear {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
          viewStore.send(.navigateToHome)
        }
      }
    }
  }
}
