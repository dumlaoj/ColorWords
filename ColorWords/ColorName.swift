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
  case purple
  case yellow
  case orange
  case pink
  
  var color: UIColor {
    switch self {
    case .blue: return .flatBlue
    case .green: return .flatGreen
    case .red: return .flatRed
    case .purple: return .flatPurple
    case .yellow: return .flatYellow
    case .orange: return .flatOrange
    case .pink: return .flatPink
    }
  }
  
}

