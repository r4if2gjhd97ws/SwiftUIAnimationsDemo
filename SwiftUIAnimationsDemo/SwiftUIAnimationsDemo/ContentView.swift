//
//  ContentView.swift
//  SwiftUIAnimationsDemo
//
//  Created by yohei on 2023/06/16.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    VStack {
      Image(systemName: "globe")
        .imageScale(.large)
        .foregroundColor(.accentColor)
      Text("Hello, world!")
      
      ADButtonCircleToPillExpandLeftRight3()
      
      ADScroll()
    }
    .padding()
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}




