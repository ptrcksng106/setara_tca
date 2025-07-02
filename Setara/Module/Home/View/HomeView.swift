//
//  HomeView.swift
//  Setara
//
//  Created by Patrick Samuel Owen Saritua Sinaga on 08/02/25.
//

import ComposableArchitecture
import SwiftUI

struct HomeView: View {
  let store: StoreOf<HomeReducer>
  
  @State private var selectedSegment = 0
  
  var body: some View {
    WithViewStore(self.store, observe: { $0 }) { viewStore in
      ZStack {
        NavigationLink(
          isActive: viewStore.binding(
            get: \.isPresentNavigation,
            send: {
              HomeReducer.Action.presentNavigation(presented: $0)
            }
          ),
          destination: {
            switch viewStore.selectedDestination {
            case .addNewBill(let store):
              AddBillView(store: store)
            default:
              EmptyView()
            }
          },
          label: {
            EmptyView()
          }
        )
        
        VStack(spacing: 16) {
          Picker(selection: $selectedSegment) {
            Text("new_bill".localized)
              .tag(0)
            Text("history".localized)
              .tag(1)
          } label: {
            Text("Picker")
          }
          .pickerStyle(SegmentedPickerStyle())
          .padding(.top, 30)
          .padding(.horizontal, 72)
          
          Spacer()
          
          switch selectedSegment {
          case 0:
            makeEmptyState(image: .imageEmptyBill, title: "add_bill_description".localized) {
              viewStore.send(.addNewbillTapped)
            }
          case 1:
            makeEmptyState(image: .imageEmptyHistory, title: "history_description".localized) {
              viewStore.send(.addNewbillTapped)
            }
          default:
            EmptyView()
          }
          
          Spacer()
          
          Text("Step 1 of 3")
            .foregroundStyle(.white.opacity(0.8))
            .font(.subheadline)
          
          ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 4)
              .fill(Color.divider.opacity(0.32))
            
            RoundedRectangle(cornerRadius: 4)
              .fill(Color.divider)
              .frame(width: UIScreen.main.bounds.size.width / 3)
          }
          .frame(height: 4)
          .padding([.horizontal, .bottom], 16)
        }
      }
      .navigationBarBackButtonHidden()
    }
  }
  
  @ViewBuilder
  private func makeEmptyState(image: ImageResource, title: String, action: @escaping (() -> Void)) -> some View {
    VStack(alignment: .center, spacing: 32) {
      Image(image)
        .resizable()
        .scaledToFill()
        .frame(width: 126, height: 126)
      
      Text(title)
        .font(.subheadline)
        .foregroundStyle(.white.opacity(0.8))
      
      PrimaryButton(text: "add_new_bill".localized) {
        action()
      }
    }
  }
}
