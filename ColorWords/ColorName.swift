//
//  ColorName.swift
//  ColorWords
//
//  Created by Jordan Dumlao on 1/20/19.
//  Copyright © 2019 Jordan Dumlao. All rights reserved.
//

import Foundation
import UIKit

enum ColorName: String, CaseIterable {
  case blue
  case green
  case red
  case yellow
  case orange
  
  var color: UIColor {
    switch self {
    case .blue: return .flatSkyBlue
    case .green: return .flatGreen
    case .red: return .flatRed
    case .yellow: return .flatYellow
    case .orange: return .flatOrange
    }
  }
  
}

