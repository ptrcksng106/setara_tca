//
//  HistoryCardView.swift
//  Setara
//
//  Created by Patrick Samuel Owen Saritua Sinaga on 09/02/25.
//

import SwiftUI

struct HistoryCardView: View {
  var date: String
  var total: Int
  
  var body: some View {
    HStack {
      Group {
        VStack(alignment: .leading, spacing: 2) {
          Text(date)
            .foregroundStyle(.white)
            .font(.title2)
          
          Text("Total amount: IDR \(total)")
            .foregroundStyle(.white.opacity(0.5))
            .font(.subheadline)
        }
        
        Spacer()
        
        HStack(spacing: 14) {
          Text("Detail")
            .foregroundStyle(.white.opacity(0.5))
            .font(.subheadline)
          
          Image(.icChevronRight)
            .resizable()
            .frame(width: 11, height: 22)
        }
      }
    }
    .background(
      RoundedRectangle(cornerRadius: 10)
        .fill(Color.blackCard)
    )
  }
}
