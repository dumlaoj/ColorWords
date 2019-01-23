//
//  GameViewController.swift
//  ColorWords
//
//  Created by Jordan Dumlao on 1/19/19.
//  Copyright © 2019 Jordan Dumlao. All rights reserved.
//

import UIKit
import ChameleonFramework

class GameViewController: UIViewController {
  
  var gameView: GameView {  return view as! GameView }
  var colorWord: ColorWord? {
    didSet {
      guard let colorWord = self.colorWord else { return }
      gameView.colorWordLabel.text = colorWord.name.rawValue.uppercased()
      gameView.colorWordLabel.textColor = colorWord.color.color
      gameView.timedProgressView.trackTintColor = colorWord.color.color
    }
  }
  
  var points: Int = 0 {
    didSet {
      gameView.pointsLabel.text = "\(points)"
    }
  }
  
  var resetFlag: Bool = true {
    didSet {
      if resetFlag {
        gameView.timedProgressView.setProgress(0, animated: false)
        restartDisplayLink()
        resetFlag.toggle()
      }
    }
  }
  
  //MARK: TIMER VARIABLES
  var elapsedTime: Float = 0 {
    didSet {
      if percentComplete >= 1 {
        endGame()
      } else {
        gameView.timedProgressView.setProgress(percentComplete, animated: true)
      }
    }
  }
  let maxTime: Float = 3.0
  var animationStartDate = Date()
  var percentComplete: Float { return Float(elapsedTime / maxTime) }
  
  /*
   CA Display Link
   */
  //  var startValue = 0
  //  let endValue = 100
  var displayLink: CADisplayLink?
  
  private func startNewGame() {
    points = 0
    colorWord = ColorWord()
    resetFlag = true
    
  }
  
  private func endGame() {
    removeDisplayLink()
    gameView.presentGameOverView()
  }
}

//MARK: View Lifecycle
extension GameViewController {
  
  override func loadView() {
    super.loadView()
    let gameView = GameView(frame: UIScreen.main.bounds)
    gameView.delegate = self
    view = gameView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    startNewGame()
    
    gameView.timedProgressView.transform = CGAffineTransform(scaleX: -1.0, y: 1.0);

  }
}

extension GameViewController: GameViewDelegate {
  func gameView(_ gameView: GameView, didStartNewGame: Bool) {
    startNewGame()
  }
  
  func gameView(_ gameView: GameView, wasSwipedInDirection swipe: UISwipeGestureRecognizer.Direction) {
    guard let colorWord = self.colorWord else { return }
    switch swipe {
    case .right:
      guard colorWord.isCorrect else { endGame(); return }
      points += 1
      self.colorWord = ColorWord()
      resetFlag = true
    case .left:
      guard !colorWord.isCorrect else { endGame(); return }
      points += 1
      self.colorWord = ColorWord()
      resetFlag = true
    default: break
    }
  }
}


//CA Display Link
extension GameViewController {
  //
  //  @objc func updatePoints() {
  //    gameView.pointsLabel.text = "\(startValue)"
  //    startValue += 1
  //  }
}

//MARK: TIMER USING CADISPLAY LINK
extension GameViewController {
  
  func restartDisplayLink() {
    removeDisplayLink()
    addDisplayLink()
  }
  
  func addDisplayLink() {
    animationStartDate = Date()
    displayLink = CADisplayLink(target: self, selector: #selector(handleUpdate(displayLink:)))
    displayLink?.add(to: .main, forMode: .default)
  }
  
  func removeDisplayLink() {
    displayLink?.invalidate()
    displayLink = nil
  }
  
  @objc func handleUpdate(displayLink: CADisplayLink) {
    let now = Date()
    elapsedTime = Float(now.timeIntervalSince(animationStartDate))
    
  }
  
}
