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
  var colorWord: ColorWord = ColorWord() {
    didSet {
      gameView.colorWord = colorWord
      gameView.timedProgressView.progressTintColor = colorWord.colorFromIndex.color
    }
  }
  
  var points: Int = 0 {
    didSet {
      gameView.pointsLabel.text = "\(points)"
    }
  }
  
  //MARK: TIMER VARIABLES
  var timer: Timer = Timer()
  let maxTime: CGFloat = 3
  var timeLeft: CGFloat = 3 {
    didSet {
      if timeLeft == maxTime {
        //gameView.timedProgressView.setProgress(Float(percentComplete), animated: false)
        gameView.timedProgressView.progress = percentComplete
        return
      } else if timeLeft < 0 {
        timer.invalidate()
        gameView.presentGameOverView()
      } else {
        gameView.timedProgressView.setProgress(Float(percentComplete), animated: true)
        //print(gameView.timedProgressView.progress)
      }
    }
  }
  var percentComplete: Float { return Float(timeLeft / maxTime) }
  
  /*
   CA Display Link
   */
//  var startValue = 0
//  let endValue = 100
//  let displayLink = CADisplayLink(target: self, selector: #selector(updatePoints))
//  displayLink.add(to: .main, forMode: .default)
  
  private func startNewGame() {
    points = 0
    colorWord = ColorWord()
    restartTimer()
  }
}

//MARK: View Lifecycle
extension GameViewController {
  
  override func loadView() {
    super.loadView()
    let gameView = GameView(frame: UIScreen.main.bounds)
    gameView.colorWord = ColorWord()
    gameView.delegate = self
    view = gameView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    startNewGame()
  }
}

extension GameViewController: GameViewDelegate {
  func gameView(_ gameView: GameView, didStartNewGame: Bool) {
    startNewGame()
  }
  
  func gameView(_ gameView: GameView, wasSwipedInDirection swipe: UISwipeGestureRecognizer.Direction) {
    switch swipe {
    case .right:
      guard colorWord.isCorrect else { timer.invalidate(); gameView.presentGameOverView(); return }
      points += 1
      colorWord = ColorWord()
      restartTimer()
    case .left:
      guard !colorWord.isCorrect else { timer.invalidate(); gameView.presentGameOverView(); return }
      points += 1
      colorWord = ColorWord()
      restartTimer()
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

//MARK: TIMER
extension GameViewController {
  
  private func configureTimer() {
    timer = Timer.scheduledTimer(withTimeInterval: 0.001, repeats: true, block: { [weak self] _ in
      self?.timeLeft -= CGFloat(0.001)
    })
  }
  
  private func restartTimer() {
    timer.invalidate()
    timeLeft = maxTime
    configureTimer()
  }
}
