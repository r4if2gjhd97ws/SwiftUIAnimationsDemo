//
//  ButtonCircleToPill.swift
//  SwiftUIAnimationsDemo
//
//  Created by yohei on 2023/06/16.
//

import SwiftUI


// button A を一回押下するとbutton Bが真円からpill型に変化する
// もう一度押下するとpill型から真円に戻る
struct ButtonCircleToPill: View {
  @State private var isExpanded = false


  var body: some View {
    HStack {

      HStack {
        Spacer()

        Text("x")
          .frame(width: 78)
        Spacer()
      }
        .background(.yellow)

      HStack {
        Button(action: {
          withAnimation {
            self.isExpanded.toggle()
          }
        }) {
          Text("A")
        }
          .padding()
          .frame(width: 71, height: 71)

      }
        .frame(alignment: .center)
        .background(.red)

      HStack {
        Spacer()
          .frame(width: isExpanded ? 50 : 96)
        Button(action: { }) {
          Text("B")
        }
          .padding()
          .frame(width: isExpanded ? 96 : 50, height: 50)
          .background(isExpanded ? .blue : .gray)
          .foregroundColor(.white)
          .clipShape(Capsule())
        Spacer()
      }
        .animation(.default, value: isExpanded)

    }
      .background()
      .frame(width: UIScreen.main.bounds.width - 20)
      .padding(.horizontal, 10)

  }
}

struct ButtonCircleToPill_Previews: PreviewProvider {
  static var previews: some View {
    ZStack {
      Color(.gray)

      ButtonCircleToPill()
    }
  }
}
