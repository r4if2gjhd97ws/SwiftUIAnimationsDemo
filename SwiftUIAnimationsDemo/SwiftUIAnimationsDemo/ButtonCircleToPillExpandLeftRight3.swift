//
//  ButtonCircleToPillExpandLeftRight3.swift
//  SwiftUIAnimationsDemo
//
//  Created by yohei on 2023/06/20.
//

import SwiftUI


enum NextButtonsType {
  case singleNext
  case bigRetrySmallNext
  case smallRetryBigNext
  case singleRetry
}

class ADButtonCircleToPillExpandLeftRightViewModel3: ObservableObject {
  enum ExpandButtonState {
    case none
    case leftExpanded
    case rightExpanded
    case allExpanded

    var next: ExpandButtonState {
      switch self {
      case .none:
        return .leftExpanded
      case .leftExpanded:
        return .rightExpanded
      case .rightExpanded:
        return .allExpanded
      case .allExpanded:
        return .none
      }
    }
  }

  @Published var expandButtonState: ExpandButtonState = .none

  @Published var _marginCenterAndLeft: CGFloat = 0
  @Published var _marginCenterAndRight: CGFloat = 0

  @Published var screenWidth: CGFloat = 0

  let commonButtonHeight: CGFloat = 70
  let smallButtonHeight: CGFloat = 33

  var smallButtonWidth: CGFloat {
//    if DeviceInfo.is
    return 96
//    / DeviceInfo.iPhone8Size.width * DeviceInfo.width
    
  }

  let horizontalMargin: CGFloat = 20 / DeviceInfo.iPhone8Size.width * DeviceInfo.width
  let bigButtonSize: CGSize = .init(width: 200, height: 56)
  let smallButtonSize: CGSize = .init(width: 83, height: 33)

  var marginLead: CGFloat {
    if expandButtonState == .leftExpanded {
      return 16 / DeviceInfo.iPhone8Size.width * DeviceInfo.width
    }
    return 10 / DeviceInfo.iPhone8Size.width * DeviceInfo.width
  }

  var marginTrailing: CGFloat {
    if expandButtonState == .leftExpanded {
      return 30 / DeviceInfo.iPhone8Size.width * DeviceInfo.width
    }
    return 10 / DeviceInfo.iPhone8Size.width * DeviceInfo.width
  }
  
  var defaultLeftButtonSize: CGSize {
    return .init(width: smallButtonWidth, height: smallButtonHeight)
  }

  var defaultRightButtonSize: CGSize {
    return .init(width: smallButtonWidth, height: smallButtonHeight)
  }

  var leftButtonSize: CGSize {
    if expandButtonState == .leftExpanded || expandButtonState == .allExpanded { return .zero }
    return .init(width: defaultLeftButtonSize.width, height: defaultLeftButtonSize.height)
  }

  var rightButtonSize: CGSize {
    if expandButtonState == .rightExpanded || expandButtonState == .allExpanded { return .zero }
    return .init(width: defaultRightButtonSize.width, height: defaultRightButtonSize.height)
  }

  var centerButtonSize: CGSize {
    return .init(width: commonButtonHeight, height: commonButtonHeight)
  }

  var leftSpacerWidth: CGFloat {
    var width: CGFloat = .zero
    switch expandButtonState {
    case .none:
      width = _marginCenterAndLeft
    case .leftExpanded:
      width = 0
    case .rightExpanded:
      width =  20 / DeviceInfo.iPhone8Size.width * DeviceInfo.width
    case .allExpanded:
      width = 0
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
      size = .init(width: defaultLeftButtonSize.width + _marginCenterAndLeft + commonButtonHeight,
        height: commonButtonHeight)

    case .rightExpanded:
      size = .init(width: defaultRightButtonSize.width + _marginCenterAndRight + commonButtonHeight,
        height: commonButtonHeight)

    case .allExpanded:
      size = .init(width: defaultLeftButtonSize.width + _marginCenterAndLeft + commonButtonHeight + defaultRightButtonSize.width + _marginCenterAndRight, height: commonButtonHeight)
    }
    print("\(#function): \(expandButtonState) - \(size)")
    return size
  }

  var rightSpacerWidth: CGFloat {
    var width: CGFloat = .zero
    switch expandButtonState {
    case .none:
      width = _marginCenterAndRight
    case .leftExpanded:
      width =  20 / DeviceInfo.iPhone8Size.width * DeviceInfo.width
    case .rightExpanded:
      width = 0
    case .allExpanded:
      width = 0
    }
    print("\(#function): \(expandButtonState) - \(width)")
    return width
  }
}

struct ADButtonCircleToPillExpandLeftRight3: View {
  @StateObject var model: ADButtonCircleToPillExpandLeftRightViewModel3

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
            RoundedRectangle(cornerRadius: model.leftButtonSize.height)
              .fill(Color.red)
              .frame(width: model.leftButtonSize.width)
              .frame(height: model.leftButtonSize.height)
            Text("A")
              .foregroundColor(.white)
          }
        }
          .opacity(model.leftButtonSize == .zero ? 0 : 1)

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
            RoundedRectangle(cornerRadius: model.rightButtonSize.height)
              .fill(Color.blue)
              .frame(width: model.rightButtonSize.width, height: model.rightButtonSize.height)
            Text("C")
              .foregroundColor(.white)
          }
        }
        .opacity(model.rightButtonSize == .zero ? 0 : 1)

        Spacer()
          .frame(width: model.marginTrailing)
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
          .frame(width: model.defaultLeftButtonSize.width, height: model.defaultLeftButtonSize.height)
          .background(.brown)

        Spacer()
          .background(GeometryReader { g in
          Color.clear.onAppear {
            Task.detached { @MainActor in
              model._marginCenterAndLeft = g.size.width
            }
          }
        })

        Spacer()
          .frame(width: model.centerButtonSize.width, height: model.centerButtonSize.height)

        Spacer()
          .background(GeometryReader { g in
          Color.clear.onAppear {
            Task.detached { @MainActor in
              model._marginCenterAndRight = g.size.width
            }
          }
        })

        Spacer()
          .frame(width: model.defaultRightButtonSize.width, height: model.defaultRightButtonSize.height)
          .background(.brown)
        
        Spacer()
          .frame(width: model.marginTrailing)
      }
        .background()
    }
  }

}

struct ADButtonCircleToPillExpandLeftRight_Previews3: PreviewProvider {
  static var previews: some View {
    ZStack {
      Color(.gray)

      ADButtonCircleToPillExpandLeftRight3()
    }
  }
}
