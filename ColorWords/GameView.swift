//
//  GameView.swift
//  ColorWords
//
//  Created by Jordan Dumlao on 1/19/19.
//  Copyright © 2019 Jordan Dumlao. All rights reserved.
//

import UIKit
import ChameleonFramework

protocol GameViewDelegate: class {
  func gameView(_ gameView: GameView, wasSwipedInDirection swipe: UISwipeGestureRecognizer.Direction)
}

class GameView: UIView {
  
  weak var delegate: GameViewDelegate?
  
  private var topContainerView: UIView = {
    let view = UIView(withBackgroundColor: .flatGray, autoLayout: true)
    return view
  }()
  
  private var bottomContainerView: UIView = {
    let view = UIView(withBackgroundColor: .flatGrayDark, autoLayout: true)
    return view
  }()
  
  private var colorWordLabel: UILabel = {
    let label = UILabel(withBackgroundColor: .clear, autoLayout: true)
    label.text = "COLOR"
    label.textAlignment = .center
    label.textColor = .flatBlack
    label.font = UIFont.boldSystemFont(ofSize: 100)
    return label
  }()
  
  private var rightSwipe = UISwipeGestureRecognizer()
  private var leftSwipe = UISwipeGestureRecognizer()
  
  private var subviewArray = [UIView]()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    subviewArray.append(contentsOf: [topContainerView, bottomContainerView])
    renderViews()
    addSwipeGestures()
    
    
  }
  
  required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
  
  private func renderViews() {
    subviewArray.forEach { addSubview($0) }
    
    let containerHeight = bounds.height / 2
    topContainerView.setHeightTo(containerHeight)
    topContainerView.constrain(leading: leadingAnchor, top: topAnchor, trailing: trailingAnchor, bottom: nil, withInset: .zero)
    
    bottomContainerView.setHeightTo(containerHeight)
    bottomContainerView.constrain(leading: leadingAnchor, top: nil, trailing: trailingAnchor, bottom: bottomAnchor, withInset: .zero)
    
    addSubview(colorWordLabel)
    colorWordLabel.centerInSuperView()
    
  }
  
  private func addSwipeGestures() {
    rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
    rightSwipe.direction = .right
    bottomContainerView.addGestureRecognizer(rightSwipe)
    
    leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
    leftSwipe.direction = .left
    bottomContainerView.addGestureRecognizer(leftSwipe)
  }
  
  @objc private func handleSwipe(_ sender: UISwipeGestureRecognizer) {
    switch sender.state {
    case .ended:
      switch sender {
        case rightSwipe: delegate?.gameView(self, wasSwipedInDirection: .right)
        case leftSwipe: delegate?.gameView(self, wasSwipedInDirection: .left)
        default: break
      }
    default:
      break
    }
  }
  
  
}
