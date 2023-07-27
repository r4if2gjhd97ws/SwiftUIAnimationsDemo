//
//  Dialog.swift
//  SwiftUIAnimationsDemo
//
//  Created by yohei on 2023/07/27.
//

import SwiftUI

class DialogModel: ObservableObject {
  init(title: String) {
    self.title = title
  }

  let title: String

  @Published var step: DialogAnimationStep = .initial

  enum DialogAnimationStep {
    case initial
    case show

    mutating func toggle() {
      switch self {
      case .initial: self = .show
      case .show: self = .initial
      }
    }

    var dialogOpacity: CGFloat {
      switch self {
      case .initial: return .zero
      case .show: return 1
      }
    }

    var dialogSize: CGSize {
      switch self {
      case .initial: return .init(width: CGFloat.zero, height: CGFloat.zero)
      case .show: return .init(width: CGFloat.infinity, height: CGFloat.infinity)
      }
    }

    var dialogOffsetY: CGFloat {
      switch self {
      case .initial: return 30
      case .show: return .zero
      }
    }

    var dialogAnimation: Animation? {
      switch self {
      case .initial: return .none
      case .show: return Animation.spring()
      }
    }

    var textScale: CGFloat {
      switch self {
      case .initial: return .zero
      case .show: return 1
      }
    }
  }
}

struct Dialog: View {
  @StateObject var model: DialogModel

  @State var on: Bool = false

  init(title: String) {
    _model = .init(wrappedValue: .init(title: title))
  }


  var body: some View {
    VStack(alignment: .center) {
      Spacer()

      Button("toggle") {
        model.step.toggle()
        print(model.step)
      }

      Spacer()

      Text(model.title)
        .clipped()
        .scaleEffect(model.step.textScale)
        .foregroundColor(.white)
        .padding(.horizontal, 40)
        .padding(.vertical, 10)
        .background(.gray)
        .cornerRadius(8)
        .frame(width: model.step.dialogSize.width, height: model.step.dialogSize.height)
        .offset(y: model.step.dialogOffsetY)
        .opacity(model.step.dialogOpacity)
        .animation(model.step.dialogAnimation, value: model.step)

      Spacer()
    }
  }
}
struct Dialog_Previews: PreviewProvider {
  static var previews: some View {
    ZStack {
      Color(.white)
      Dialog(title: "だいあろぐタイトル\nダイアログたいとる")
    }
  }
}
