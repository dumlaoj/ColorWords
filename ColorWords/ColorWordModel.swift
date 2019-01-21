//
//  ColorWordModel.swift
//  ColorWords
//
//  Created by Jordan Dumlao on 1/19/19.
//  Copyright © 2019 Jordan Dumlao. All rights reserved.
//

import Foundation

struct ColorWord {
  let nameIndex: Int
  let colorIndex: Int
  
  var isCorrect: Bool { return nameIndex == colorIndex }
  var colorFromIndex: ColorName { return ColorName.allCases[self.colorIndex] }
  var name: ColorName { return ColorName.allCases[self.nameIndex] }
  
  init() {
    let count = ColorName.allCases.count
    self.nameIndex = count.randomNumber
    self.colorIndex = count.randomNumber
  }
  
}

extension Int {
  var randomNumber: Int {
    let absNumber = abs(self)
    return Int(arc4random_uniform(UInt32(absNumber)))
  }
}
