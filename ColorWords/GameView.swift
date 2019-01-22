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
  func gameView(_ gameView: GameView, didStartNewGame: Bool)
}

class GameView: UIView {
  
  weak var delegate: GameViewDelegate?
  var colorWord: ColorWord {
    get {
      return ColorWord()
    }
    set {
      colorWordLabel.text = newValue.name.rawValue.uppercased()
      colorWordLabel.textColor = newValue.colorFromIndex.color
    }
  }
  
  private var topContainerView: UIView = {
    let view = UIView(backgroundColor: .white)
    return view
  }()
  
  private var bottomContainerView: UIView = {
    let view = UIView(backgroundColor: .white)
    return view
  }()
  
  private var colorWordLabel: UILabel = {
    let label = UILabel(backgroundColor: .clear, textLabel: "COLOR")
    label.textAlignment = .center
    label.textColor = .flatBlack
    label.font = UIFont.boldSystemFont(ofSize: 75)
    label.adjustsFontSizeToFitWidth = true
    return label
  }()
  
  var pointsLabel: UILabel = {
    let label = UILabel(backgroundColor: .clear, textLabel: "00")
    label.text = "00"
    label.textColor = .black
    label.textAlignment = .center
    return label
  }()
  
  var timedProgressView: UIProgressView = {
    let progressView = UIProgressView(backgroundColor: .lightGray)
    progressView.setProgress(1, animated: false)
    progressView.clipsToBounds = true
    return progressView
  }()
  
  
  
  var gameOverView: BlurredPopupView = {
    let view = BlurredPopupView(backgroundColor: .clear)
    view.text = "GAME OVER"
    view.layer.cornerRadius = 10.0
    view.clipsToBounds = true
    view.containerViewBackgroundColor = .clear
    return view
  }()
  
  private var rightSwipe = UISwipeGestureRecognizer()
  private var leftSwipe = UISwipeGestureRecognizer()
  private var tap = UITapGestureRecognizer()
  
  private var subviewArray = [UIView]()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    subviewArray.append(contentsOf: [topContainerView, bottomContainerView, colorWordLabel])
    renderViews()
    addSwipeGestures()
  }
  
  required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
  
  private func renderViews() {
    subviewArray.forEach { addSubview($0) }
    
    let containerHeight = bounds.height / 2
    topContainerView.constrain(withHeight: containerHeight)
    topContainerView.constrain(toLeading: leadingAnchor, top: topAnchor, trailing: trailingAnchor, bottom: nil, withPadding: .zero)
    
    bottomContainerView.constrain(withHeight: containerHeight)
    bottomContainerView.constrain(toLeading: leadingAnchor, top: nil, trailing: trailingAnchor, bottom: bottomAnchor, withPadding: .zero)
    
    //addSubview(colorWordLabel)
    colorWordLabel.allignVertically(to: self, 0)
    colorWordLabel.constrain(toLeading: leadingAnchor, top: nil, trailing: trailingAnchor, bottom: nil, withPadding: UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30))
    
    topContainerView.addSubview(pointsLabel)
    pointsLabel.constrain(withSize: CGSize(width: 100, height: 100))
    
    pointsLabel.constrain(toLeading: nil, top: topContainerView.topAnchor, trailing: nil, bottom: nil, withPadding: UIEdgeInsets(top: 30, left: 0, bottom: 0, right: 0))
    pointsLabel.allignHorizontally(to: topContainerView, 0)
    
    //TIMED PROGRESS VIEW
    let heightForProgressView: CGFloat = 20
    bottomContainerView.addSubview(timedProgressView)
    timedProgressView.allignHorizontally(to: bottomContainerView, 0)
    timedProgressView.allignVertically(to: bottomContainerView, -100)
    timedProgressView.widthAnchor.constraint(equalTo: bottomContainerView.widthAnchor, multiplier: 3/4, constant: 0).isActive = true
    timedProgressView.constrain(withHeight: heightForProgressView)
    timedProgressView.layer.cornerRadius = heightForProgressView / 2
    
    //GAME OVER VIEW
    addSubview(gameOverView)
    gameOverView.fillSuperview()
  }
  
  private func addSwipeGestures() {
    rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
    rightSwipe.direction = .right
    addGestureRecognizer(rightSwipe)
    
    leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
    leftSwipe.direction = .left
    addGestureRecognizer(leftSwipe)
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
  
  func presentGameOverView() {
    
    gameOverView.animatePopup()
    
    tap = UITapGestureRecognizer(target: self, action: #selector(handleGameOverTap(_:)))
    self.addGestureRecognizer(tap)
  }
  
  @objc private func handleGameOverTap(_ sender: UITapGestureRecognizer) {
    switch sender.state {
    case .ended:
      self.removeGestureRecognizer(tap)
      gameOverView.removePopup()
      delegate?.gameView(self, didStartNewGame: true)
    default:
      break
    }
  }
}

