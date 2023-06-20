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
  
  let commonButtonHeight: CGFloat = 70
  let horizontalMargin: CGFloat = 20 / DeviceInfo.iPhone8Size.width * DeviceInfo.width
  let bigButtonSize: CGSize = .init(width: 200, height: 56)
  let smallButtonSize: CGSize = .init(width: 83, height: 33)
  
  var leftButtonSize: CGSize {
    return .init(width: commonButtonHeight, height: commonButtonHeight)
  }
  
  var rightButtonSize: CGSize {
    return .init(width: commonButtonHeight, height: commonButtonHeight)
  }
  
  var centerButtonSize: CGSize {
    return .init(width: commonButtonHeight, height: commonButtonHeight)
  }
  
  var leftSpacerWidth: CGFloat {
    var width: CGFloat = .zero
    switch expandButtonState {
    case .none:
      width = leftButtonSize.width + marginCenterAndLeft
    case .leftExpanded:
      width = 0
    case .rightExpanded:
      width = leftButtonSize.width + marginCenterAndLeft
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
      size = .init(width: leftButtonSize.width + marginCenterAndLeft + commonButtonHeight,
                   height: commonButtonHeight)
      
    case .rightExpanded:
      size = .init(width: rightButtonSize.width + marginCenterAndLeft + commonButtonHeight,
                   height: commonButtonHeight)
    }
    print("\(#function): \(expandButtonState) - \(size)")
    return size
  }
  
  var rightSpacerWidth: CGFloat {
    var width: CGFloat = .zero
    switch expandButtonState {
    case .none:
      width = rightButtonSize.width + marginCenterAndRight
    case .leftExpanded:
      width = rightButtonSize.width + marginCenterAndRight
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
      HStack(spacing: 0) {
        Button(action: {
          print("A is tapped")
        }) {
          ZStack {
            Circle()
              .fill(Color.red)
              .frame(width: model.leftButtonSize.width, height: model.leftButtonSize.height)
            Text("A")
              .foregroundColor(.white)
          }
        }
        .opacity(model.expandButtonState == .leftExpanded ? 0 : 1)
        
        Spacer()
          .background(GeometryReader { g in
            Color.clear.onAppear {
              DispatchQueue.main.async {
                model.marginCenterAndLeft = g.size.width
                print(model.marginCenterAndLeft)
              }
            }
          })
        
        Button(action: { }) {
          ZStack {
            Circle()
              .fill(Color.yellow)
              .frame(width: model.centerButtonSize.width, height: model.centerButtonSize.height)
            Text("dummy")
              .foregroundColor(.white)
          }
        }
        
        Spacer()
          .background(GeometryReader { g in
            Color.clear.onAppear {
              DispatchQueue.main.async {
                model.marginCenterAndRight = g.size.width
                print(model.marginCenterAndRight)
              }
            }
          })
        
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
        .opacity(model.expandButtonState == .rightExpanded ? 0 : 1)
      }
      .background()
      
      HStack(spacing: 0) {
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
      }
      .background(UIColor.cyan.withAlphaComponent(0.3).swiftUI)
      .animation(.default, value: model.expandButtonState)
      
      
      
    }
    .padding(.horizontal, model.horizontalMargin)
  }
  
  
  var buttonA: some View {
    Button(action: {
      print("A is tapped")
    }) {
      ZStack {
        Circle()
          .fill(Color.red)
          .frame(width: model.leftButtonSize.width, height: model.leftButtonSize.height)
        Text("A")
          .foregroundColor(.white)
      }
    }
    .opacity(model.expandButtonState == .leftExpanded ? 0 : 1)
    
    
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
