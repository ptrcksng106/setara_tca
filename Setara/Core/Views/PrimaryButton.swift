//
//  PrimaryButton.swift
//  Setara
//
//  Created by Patrick Samuel Owen Saritua Sinaga on 09/02/25.
//

import SwiftUI

struct PrimaryButton: View {
  var text: String
  var onTapped: (() -> Void)
  
  var body: some View {
    Button(action: {
      onTapped()
    }) {
      Text(text)
        .font(.subheadline)
        .foregroundStyle(.white)
        .padding(.horizontal, 30)
        .frame(height: 40)
        .background(
          Rectangle()
            .fill(Color.primarySetara)
            .cornerRadius(12)
        )
        .clipped()
    }
  }
}
