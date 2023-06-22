//
//  ADSpringAnimation.swift
//  SwiftUIAnimationsDemo
//
//  Created by yohei on 2023/06/22.
//

import SwiftUI

protocol ADSpringAnimationDelegate {
  
}

class ADSpringAnimationModel: ObservableObject {
  @Published var shouldShowTag: Bool = false
  @Published var shouldShowUpper: Bool = false
  
  @Published var moveLowerTag: Bool = false
  @Published var moveUpperTag: Bool = false
  
  let tagHeight: CGFloat = 26
  let tagSpace: CGFloat = 6
  
  var buttonTitle: String {
    return "tag toggle: \(shouldShowTag)"
  }
  
  func animate() {
    shouldShowTag = true
    
    DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(250)) {
      self.shouldShowUpper = true
    }
    
  }
  
  func reset() {
    shouldShowTag = false
    shouldShowUpper = false
    moveLowerTag = false
    moveUpperTag = false
  }
  
  let tagReadlyPosition: CGFloat = 20
}

struct ADSpringAnimation: View {
  var delegate: ADSpringAnimationDelegate?
  @StateObject var model: ADSpringAnimationModel
  
  init() {
    _model = .init(wrappedValue: .init())
  }
  
  var body: some View {
    GeometryReader { geometry in
      
      
      VStack {
        Button(model.buttonTitle) {
          model.shouldShowTag.toggle()
          
          if model.shouldShowTag {
            model.animate()
          } else {
            model.reset()
          }
          
          print("model.shouldShowTag: \(model.shouldShowTag)")
        }
        
        Spacer()
          .frame(height: 50)
        
        ZStack(alignment: .topTrailing) {
          VStack {
            Text("AAAAAAAAAAAAAA")
            Text("BBBBBBBBBBBBBB")
          }
          if model.shouldShowTag {
            tags()
          }
        }
        .background(.red)
        .frame(height: 300)
        .frame(width: geometry.size.width - 20)
        .cornerRadius(6)
        .frame(alignment: .bottom)
        
      }
    }
  }
  
  private func tags() -> some View {
    VStack {
      if model.shouldShowUpper {
        Text("tag upper")
          .padding(.horizontal, 10)
          .background(.green)
          .frame(height: model.tagHeight)
          .offset(x: model.moveUpperTag ? .zero : model.tagReadlyPosition)
          .onAppear {
            withAnimation(.spring()) {
              model.moveUpperTag = true
            }
          }
        
        Spacer().frame(height: model.tagSpace)
      }
      
      
      Text("tag lower")
        .padding(.horizontal, 10)
        .background(.yellow)
        .frame(height: model.tagHeight)
        .offset(x: model.moveLowerTag ? .zero : model.tagReadlyPosition)
        .onAppear {
          withAnimation(.spring()) {
            model.moveLowerTag = true
          }
        }
    }
    .frame(height: (model.shouldShowUpper ? model.tagHeight + model.tagSpace : 0) + model.tagHeight)
    .padding(.trailing, 12)
    .padding(.top, -(model.shouldShowUpper ? model.tagHeight + model.tagSpace : 0) - model.tagHeight / 2)
    
    
    
  }
}

struct ADSpringAnimation_Previews: PreviewProvider {
  static var previews: some View {
    ZStack {
      Color(.gray)
      
      ADSpringAnimation()
    }
  }
}
