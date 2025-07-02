//
//  AddBillView.swift
//  Setara
//
//  Created by Patrick Samuel Owen Saritua Sinaga on 09/02/25.
//

import ComposableArchitecture
import SwiftUI

struct AddBillView: View {
  @Environment(\.presentationMode) var presentationMode
  let store: StoreOf<AddBillReducer>
  
  var body: some View {
    WithViewStore(self.store, observe: { $0 }) { viewStore in
      ZStack {
        
        VStack(alignment: .leading, spacing: 8) {
          HStack(alignment: .top, spacing: 3) {
            Image(.icChevronLeft)
              .resizable()
              .scaledToFill()
              .frame(width: 17, height: 17)
            
            Text("back".localized)
              .foregroundStyle(.primarySetara)
              .font(.title3)
              .onTapGesture {
                presentationMode.wrappedValue.dismiss()
              }
            
            Spacer()
            
            Text("add_bill".localized)
              .foregroundStyle(.primarySetara)
              .font(.title3)
              .onTapGesture {
                viewStore.send(.addBillTapped)
              }
          }
          .padding(.top, 10)
          
          Group {
            Text("add_bill".localized)
              .font(.title)
              .onTapGesture {
                viewStore.send(.addBillTapped)
              }
            
            Text("add_bill_description".localized)
              .foregroundStyle(.white.opacity(0.8))
              .font(.subheadline)
            
            CardBillView(item: .init(name: "Mie Tarempa   x2", totalPrice: "Rp 66.000", tax: 10, fee: 10, discount: 10, participantName: "Patrick"))
            
            CardBillView(item: .init(name: "Mie Tarempa   x2", totalPrice: "Rp 66.000", tax: 10, fee: 10, discount: 10, participantName: "Patrick"))
            
            Spacer()
            
            PrimaryButton(text: "done".localized) {
              //TODO: implement action here
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.bottom, 20)
          }
          .padding(.horizontal, 16)
          
          BottomSheet(
            isOpen: viewStore.binding(
              get: {
                $0.isShowBottomsheet
              },
              send: { value in
                return .toggleBottomsheet(isShowed: value)
              }),
            maxHeight: 300,
            minHeight: 0,
            onSwipeDismissed: { }) {
              HStack {
                Text("Add Item")
                  .foregroundStyle(.white)
                  .font(.body)
                
                Spacer()
                
                Button(action: {
                  
                }) {
                  Image(.icCircleAdd)
                    .resizable()
                    .frame(width: 30, height: 30)
                }
              }
            }
        }
      }
      .navigationBarBackButtonHidden()
    }
  }
}
