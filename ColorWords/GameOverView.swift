//
//  GameOverView.swift
//  ColorWords
//
//  Created by Jordan Dumlao on 1/21/19.
//  Copyright © 2019 Jordan Dumlao. All rights reserved.
//

import UIKit

class GameOverView: UIView {
  
  var gameOverLabel: UILabel = {
    let label = UILabel(withBackgroundColor: .lightGray, autolayout: true)
    label.text = "GAME OVER"
    label.font = UIFont.boldSystemFont(ofSize: 25)
    label.adjustsFontSizeToFitWidth = true
    label.textAlignment = .center
    return label
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    addSubviews()
    renderViews()
  }
  
  required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
  
  private func addSubviews() {
    let views: [UIView] = [gameOverLabel]
    views.forEach { addSubview($0)}
  }
  
  private func renderViews() {
    gameOverLabel.fillSuperview()
  }
}
