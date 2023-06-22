//
//  ADLayout.swift
//  SwiftUIAnimationsDemo
//
//  Created by yohei on 2023/06/21.
//

import SwiftUI

protocol ADLayoutDelegate {
  
}

class ADLayoutModel {
  
}

struct ADLayout: View {
  var delegate: ADLayoutDelegate?
  var model: ADLayoutModel
  
  init() {
    self.model = .init()
  }
  
  var body: some View {
    GeometryReader { geometry in
      ZStack(alignment: .trailing) {
        buttonViewA
          .frame(width: geometry.size.width)
        HStack {
          Spacer()
          buttonViewB
          Spacer()
        }
        .background(.yellow)
        .frame(width: geometry.size.width / 2)
      }
      .background(.brown)
    }
    .frame(height: 110)
  }
  
  var buttonViewA: some View {
    Button("A") {
      print("A tapped")
    }
    .frame(width: 70)
    .frame(height: 70)
    .background(UIColor.red.withAlphaComponent(0.3).swiftUI)
  }
  
  var buttonViewB: some View {
    Button("B") {
      print("B tapped")
    }
    .frame(height: 70)
    .frame(width: 70)
    .background(UIColor.blue.withAlphaComponent(0.3).swiftUI)
  }
}





struct ADLayout_Previews: PreviewProvider {
  static var previews: some View {
    ZStack {
      Color(.gray)
      
      ADLayout()
    }
  }
}
