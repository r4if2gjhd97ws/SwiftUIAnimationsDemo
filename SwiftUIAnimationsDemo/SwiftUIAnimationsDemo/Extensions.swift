//
//  Extensions.swift
//  SwiftUIAnimationsDemo
//
//  Created by yohei on 2023/06/16.
//

import Foundation
import SwiftUI

extension CGFloat {
  var convertedWidthByDevice: CGFloat {
    return self / DeviceInfo.iPhone8Size.width * DeviceInfo.width
  }

  var convertedHeightByDevice: CGFloat {
    return self / DeviceInfo.iPhone8Size.height * DeviceInfo.height
  }
}

extension UIColor {
  var swiftUI: Color {
    return Color(self)
  }
}

class DeviceInfo {
  static let iPhone8Size = CGSize(width: 375, height: 667)
  class var height: CGFloat {
    return UIScreen.main.bounds.size.height
  }
  class var width: CGFloat {
    return UIScreen.main.bounds.size.width
  }
}
