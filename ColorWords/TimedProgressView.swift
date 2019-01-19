//
//  BezierView.swift
//  BezierPathDemo
//
//  Created by Jordan Dumlao on 1/18/19.
//  Copyright © 2019 Jordan Dumlao. All rights reserved.
//

import UIKit

class TimedProgressView: UIView, CAAnimationDelegate {

  var shadeShape = CAShapeLayer()
  var straightLinePath: UIBezierPath?
  
  var strokeEnd: CGFloat {
    get {
      return shadeShape.strokeEnd
    }
    set {
      shadeShape.strokeEnd = newValue
    }
  }
  
  override func draw(_ rect: CGRect) {
    super.draw(rect)
    
    configurePath()
    configureShape()
  }
  
  private func configureShape() {
    shadeShape.lineWidth = self.bounds.height
    shadeShape.path = straightLinePath?.cgPath
    shadeShape.strokeColor = UIColor.red.cgColor
    shadeShape.strokeEnd = 0
    layer.addSublayer(shadeShape)
  }
  
  private func configurePath() {
    let path = UIBezierPath()
    path.move(to: CGPoint(x: self.bounds.minX, y: self.bounds.height / 2))
    path.addLine(to: CGPoint(x: self.bounds.maxX, y: self.bounds.height / 2))
    straightLinePath = path
  }

}
