//
//  ButtonCircleToPillExpandLeftRight2.swift
//  SwiftUIAnimationsDemo
//
//  Created by yohei on 2023/06/16.
//

import SwiftUI


class ADButtonCircleToPillExpandLeftRightViewModel2: ObservableObject {
  enum ExpandButtonState {
    case none
    case leftExpanded
    case rightExpanded

    var next: ExpandButtonState {
      switch self {
      case .none: return .leftExpanded
      case .leftExpanded: return .rightExpanded
      case .rightExpanded: return .none
      }
    }
  }

  @Published var expandButtonState: ExpandButtonState = .none

  @Published var marginCenterAndLeft: CGFloat = 0
  @Published var marginCenterAndRight: CGFloat = 0

  @Published var screenWidth: CGFloat = 0

  let commonButtonHeight: CGFloat = 70
  let horizontalMargin: CGFloat = 20 / DeviceInfo.iPhone8Size.width * DeviceInfo.width
  let bigButtonSize: CGSize = .init(width: 200, height: 56)
  let smallButtonSize: CGSize = .init(width: 83, height: 33)

  var marginLead: CGFloat {
    return 10
  }

  var marginTrailing: CGFloat {
    return 10
  }

  var defaultLeftButtonSize: CGSize {
    return .init(width: commonButtonHeight, height: commonButtonHeight)
  }

  var defaultRightButtonSize: CGSize {
    return .init(width: commonButtonHeight, height: commonButtonHeight)
  }

  var leftButtonSize: CGSize {
    if expandButtonState == .leftExpanded { return .zero }
    return .init(width: commonButtonHeight, height: commonButtonHeight)
  }

  var rightButtonSize: CGSize {
    if expandButtonState == .rightExpanded { return .zero }
    return .init(width: commonButtonHeight, height: commonButtonHeight)
  }

  var centerButtonSize: CGSize {
    return .init(width: commonButtonHeight, height: commonButtonHeight)
  }

  var leftSpacerWidth: CGFloat {
    var width: CGFloat = .zero
    switch expandButtonState {
    case .none:
      width =
//      defaultLeftButtonSize.width +
      marginCenterAndLeft
    case .leftExpanded:
      width = 0
    case .rightExpanded:
      width =
//      defaultLeftButtonSize.width +
      marginCenterAndLeft
    }
    print("\(#function): \(expandButtonState) - \(width)")
    return width
  }

  var expandedCenterButtonSize: CGSize {
    var size: CGSize = .zero
    switch expandButtonState {
    case .none:
      size = .init(width: commonButtonHeight,
        height: commonButtonHeight)
    case .leftExpanded:
      size = .init(width: defaultLeftButtonSize.width + marginCenterAndLeft + commonButtonHeight,
        height: commonButtonHeight)

    case .rightExpanded:
      size = .init(width: defaultRightButtonSize.width + marginCenterAndLeft + commonButtonHeight,
        height: commonButtonHeight)
    }
    print("\(#function): \(expandButtonState) - \(size)")
    return size
  }

  var rightSpacerWidth: CGFloat {
    var width: CGFloat = .zero
    switch expandButtonState {
    case .none:
      width =
      marginCenterAndRight
    case .leftExpanded:
      width =
      marginCenterAndRight
    case .rightExpanded:
      width = 0
    }
    print("\(#function): \(expandButtonState) - \(width)")
    return width
  }
}

struct ADButtonCircleToPillExpandLeftRight2: View {
  @StateObject var model: ADButtonCircleToPillExpandLeftRightViewModel2

  init() {
    _model = .init(wrappedValue: .init())
  }

  var body: some View {
    ZStack {
      hiddenBackground

      HStack(spacing: 0) {
        Spacer()
          .frame(width: model.marginLead)


        Button(action: {
          print("A is tapped")
        }) {
          ZStack {
            Circle()
              .fill(Color.red)
              .frame(width: model.leftButtonSize.width,
              height: model.leftButtonSize.height)
            Text("A")
              .foregroundColor(.white)
          }
        }
          .opacity(model.expandButtonState == .leftExpanded ? 0 : 1)

        Spacer()
          .frame(height: 10)
          .frame(width: model.leftSpacerWidth)
          .background(.yellow)

        Button(action: {
          withAnimation {
            model.expandButtonState = model.expandButtonState.next
            print(model.expandButtonState)
          }
        }) {
          ZStack {
            RoundedRectangle(cornerRadius: model.commonButtonHeight)
              .fill(UIColor.green.withAlphaComponent(0.3).swiftUI)
              .frame(width: model.expandedCenterButtonSize.width, height: model.expandedCenterButtonSize.height)
            Text("B")
          }
        }

        Spacer()
          .frame(height: 10)
          .frame(width: model.rightSpacerWidth)
          .background(.brown)


        Button(action: {
          print("C is tapped")
        }) {
          ZStack {
            Circle()
              .fill(Color.blue)
              .frame(width: model.rightButtonSize.width, height: model.rightButtonSize.height)
            Text("C")
              .foregroundColor(.white)
          }
        }

        Spacer()
          .frame(width: model.marginTrailing)
          .opacity(model.expandButtonState == .rightExpanded ? 0 : 1)
      }
        .background()
    }
  }

  private var hiddenBackground: some View {
    ZStack {
      HStack(spacing: 0) {

        Spacer()
          .frame(width: model.marginLead)

        Spacer()
          .frame(width: model.leftButtonSize.width, height: model.leftButtonSize.height)

        Spacer()
          .background(GeometryReader { g in
          Color.clear.onAppear {
            Task.detached { @MainActor in
              model.marginCenterAndLeft = g.size.width
            }
          }
        })

        Spacer()
          .frame(width: model.centerButtonSize.width, height: model.centerButtonSize.height)

        Spacer()
          .background(GeometryReader { g in
          Color.clear.onAppear {
            Task.detached { @MainActor in
              model.marginCenterAndRight = g.size.width
            }
          }
        })

        Spacer()
          .frame(width: model.rightButtonSize.width, height: model.rightButtonSize.height)

        Spacer()
          .frame(width: model.marginTrailing)
      }
        .background()
    }
  }

}

struct ADButtonCircleToPillExpandLeftRight_Previews2: PreviewProvider {
  static var previews: some View {
    ZStack {
      Color(.gray)

      ADButtonCircleToPillExpandLeftRight2()
    }
  }
}
