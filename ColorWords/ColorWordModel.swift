//
//  ColorWordModel.swift
//  ColorWords
//
//  Created by Jordan Dumlao on 1/19/19.
//  Copyright © 2019 Jordan Dumlao. All rights reserved.
//

import Foundation

struct ColorWord: Equatable {
  
  static func == (lhs: ColorWord, rhs: ColorWord) -> Bool {
    return lhs.name == rhs.name && lhs.color == rhs.color
  }
  
  let name: ColorName
  let color: ColorName
  
  var isCorrect: Bool { return name == color }
  //var colorFromIndex: ColorName { return ColorName.allCases[self.color] }
  //var name: ColorName { return ColorName.allCases[self.name] }
  
  init() {
    let count = ColorName.allCases.count
    let colorName = ColorName.allCases[count.randomNumber]
    self.name = colorName
    
    self.color = ColorWord.createColorFrom(colorName)
  }
  
  static func createColorFrom(_ colorName: ColorName) -> ColorName{
    let allCases = ColorName.allCases
    let count = allCases.count
    var array = [ColorName]()
    for _ in 1 ... (count) {
      array.append(colorName)
    }
    
    let combinedArray = allCases + array
    //print("\(combinedArray) \n")
    let randomIndex = combinedArray.count.randomNumber
    let newColorName = combinedArray[randomIndex]
    return newColorName
  }
  
}

extension Int {
  var randomNumber: Int {
    let absNumber = abs(self)
    return Int(arc4random_uniform(UInt32(absNumber)))
  }
}
