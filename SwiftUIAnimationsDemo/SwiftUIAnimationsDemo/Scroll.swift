//
//  Scroll.swift
//  SwiftUIAnimationsDemo
//
//  Created by yohei on 2023/06/22.
//

import SwiftUI
import Combine

struct ADScroll: View {
    let detector: CurrentValueSubject<CGFloat, Never>
    let publisher: AnyPublisher<CGFloat, Never>

    init() {
        let detector = CurrentValueSubject<CGFloat, Never>(0)
        self.publisher = detector
            .debounce(for: .seconds(0.2), scheduler: DispatchQueue.main)
            .dropFirst()
            .eraseToAnyPublisher()
        self.detector = detector
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ForEach(0...100, id: \.self) { i in
                    Rectangle()
                        .frame(width: 200, height: 100)
                        .foregroundColor(.green)
                        .overlay(Text("\(i)"))
                }
            }
            .frame(maxWidth: .infinity)
            .background(GeometryReader {
                Color.clear.preference(key: ViewOffsetKey.self,
                    value: -$0.frame(in: .named("scroll")).origin.y)
            })
            .onPreferenceChange(ViewOffsetKey.self) { detector.send($0) }
        }.coordinateSpace(name: "scroll")
        .onReceive(publisher) {
            print("Stopped on: \($0)")
        }
    }
}

struct ViewOffsetKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue = CGFloat.zero
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}


struct ADScroll_Preview: PreviewProvider {
  
  static var previews: some View {
    ZStack {
      Color.gray
      
      ADScroll()
    }
  }
}
