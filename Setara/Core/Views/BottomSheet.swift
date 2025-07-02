//
//  BottomSheet.swift
//  Setara
//
//  Created by Patrick Samuel Owen Saritua Sinaga on 24/05/25.
//

import SwiftUI

struct BottomSheet<Content: View>: View {
  @Binding var isOpen: Bool
  var maxHeight: CGFloat
  var minHeight: CGFloat
  var isClickableDismissed: Bool
  var onSwipeDismissed: (() -> Void)?
  let content: Content
  let isHideBackground: Bool
  
  private var offset: CGFloat {
    isOpen ? 0 : maxHeight - minHeight
  }
  
  @GestureState private var translation: CGFloat = 0
  
  init(
    isOpen: Binding<Bool>,
    maxHeight: CGFloat,
    minHeight: CGFloat,
    isClickableDismissed: Bool = false,
    isHideBackground: Bool = false,
    onSwipeDismissed: (() -> Void)?,
    @ViewBuilder content: () -> Content
  ) {
    self._isOpen = isOpen
    self.maxHeight = maxHeight
    self.minHeight = minHeight
    self.content = content()
    self.onSwipeDismissed = onSwipeDismissed
    self.isClickableDismissed = isClickableDismissed
    self.isHideBackground = isHideBackground
  }
  
  var body: some View {
    GeometryReader { geometry in
      ZStack {
        if (isOpen && isHideBackground == false) {
          Color.black.opacity(0.6)
            .onTapGesture {
              if(isClickableDismissed) {
                isOpen = false
              }
            }
        }
        
        VStack(spacing: 0) {
          // Grabber
          RoundedRectangle(cornerRadius: 5.0)
            .frame(width: 36, height: 6)
            .foregroundColor(.secondaryText)
            .padding(.top, 16)
            .padding(.bottom, 8)
          
          // Content
          self.content
        }
        .frame(width: geometry.size.width, height: self.maxHeight, alignment: .top)
        .background(.bottomsheet)
        .cornerRadius(32, corners: [.topLeft, .topRight])
        .shadow(radius: 5)
        .frame(height: geometry.size.height, alignment: .bottom)
        .offset(y: max(self.offset + self.translation, 0))
        .animation(.interactiveSpring(), value: isOpen)
        .gesture(
          DragGesture().updating(self.$translation) { value, state, _ in
            state = value.translation.height
          }
            .onEnded { value in
              let snapDistance = self.maxHeight * 0.25
              guard abs(value.translation.height) > snapDistance else {
                return
              }
              
              self.isOpen = value.translation.height < 0
              if(!self.isOpen) {
                self.onSwipeDismissed?()
              }
            }
        )
      }
    }
  }
}
