//
//  ADLayout2.swift
//  SwiftUIAnimationsDemo
//
//  Created by yohei on 2023/06/22.
//

import SwiftUI

protocol ADLayout2Delegate {

}

class ADLayout2Model {

}

struct ADLayout2: View {
  var delegate: ADLayout2Delegate?
  var model: ADLayout2Model

  @State var buttonViewBWidth: CGFloat = 0

  init() {
    self.model = .init()
  }

  var body: some View {
    GeometryReader { geometry in
      ZStack(alignment: .trailing) {
        buttonViewA
          .frame(width: geometry.size.width)

        buttonViewB
          .background(GeometryReader(content: { g in
          Color.clear.onAppear {
            buttonViewBWidth = g.size.width
          }
        }))
          .padding(.trailing, ((geometry.size.width / 2) - buttonViewBWidth) / 2)
          .background(.yellow)

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

struct ADLayout2_Previews: PreviewProvider {
  static var previews: some View {
    ZStack {
      Color(.gray)

      ADLayout2()
    }
  }
}
