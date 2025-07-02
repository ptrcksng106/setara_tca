//
//  CardBillView.swift
//  Setara
//
//  Created by Patrick Samuel Owen Saritua Sinaga on 24/05/25.
//

import SwiftUI

struct CardBillItem: Equatable {
  let name: String
  let totalPrice: String
  let tax: Int?
  let fee: Int?
  let discount: Int?
  let participantName: String?
}

struct CardBillView: View {
  let item: CardBillItem
  var onTappedEdit: (() -> Void)? = nil
  var onTappedAdd: (() -> Void)? = nil
  
  var body: some View {
    VStack(alignment: .leading) {
      HStack(spacing: 16) {
        VStack(alignment: .leading, spacing: 0) {
          Text(item.name)
            .foregroundStyle(.white)
            .font(.callout)
          
          Text(item.totalPrice)
            .foregroundStyle(.secondaryText)
            .font(.caption)
        }
        
        Spacer()
        
        Group {
          Text("Edit")
            .foregroundStyle(.secondaryText)
            .font(.callout)
          
          Image(.icChevronRight)
            .resizable()
            .renderingMode(.template)
            .frame(width: 11, height: 22)
            .foregroundStyle(.secondaryText)
        }
        .onTapGesture {
          onTappedEdit?()
        }
      }
      .padding(.horizontal, 16)
      .padding(.top, 8)
      
      Divider()
      
      HStack {
        Text("Participant: \(item.participantName ?? "")")
          .foregroundStyle(.secondaryText)
          .font(.caption)
        
        Spacer()
        
        Button(action: {
          onTappedAdd?()
        }) {
          Image(.icCircleAdd)
            .resizable()
            .frame(width: 19, height: 19)
        }
      }
      .padding(.horizontal, 16)
      .padding(.bottom, 8)
    }
    .background(
      RoundedRectangle(cornerRadius: 10)
        .fill(.blackCard)
    )
  }
}
