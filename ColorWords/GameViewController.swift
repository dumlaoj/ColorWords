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
      print(colorWord.colorIndex)
      print(colorWord.nameIndex)
      print("\n")
    }
  }
  
  var points: Int = 0 {
    didSet {
      gameView.pointsLabel.text = "\(points)"
    }
  }
  
  //MARK: TIMER VARIABLES
  var timer: Timer = Timer()
  let maxTime: CGFloat = 5
  var percentTimeCompete: CGFloat = 5 {
    didSet {
      if percentTimeCompete == 5 {
        gameView.timedProgressView.setProgress(1.0, animated: false)
        return
      }
      gameView.timedProgressView.setProgress(Float(timeRemoved), animated: true)
      if percentTimeCompete <= 0 {
        timer.invalidate()
        print("timer stopped")
      }
    }
  }
  var timeRemoved: CGFloat { return percentTimeCompete / maxTime }
  
  /*
   CA Display Link
   */
//  var startValue = 0
//  let endValue = 100
//  let displayLink = CADisplayLink(target: self, selector: #selector(updatePoints))
//  displayLink.add(to: .main, forMode: .default)
  
  override func loadView() {
    super.loadView()
    let gameView = GameView(frame: UIScreen.main.bounds)
    gameView.colorWord = ColorWord()
    gameView.delegate = self
    view = gameView
  }
}

//MARK: View Lifecycle
extension GameViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    configureTimer()
  }
}

extension GameViewController: GameViewDelegate {
  func gameView(_ gameView: GameView, wasSwipedInDirection swipe: UISwipeGestureRecognizer.Direction) {
    switch swipe {
    case .right:
      guard colorWord.isCorrect else { timer.invalidate(); print("GAME OVER"); return }
      points += 1
      colorWord = ColorWord()
      restartTimer()
    case .left:
      guard !colorWord.isCorrect else { timer.invalidate(); print("GAME OVER"); return }
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
    timer = Timer.scheduledTimer(withTimeInterval: 0.001, repeats: true, block: { [weak self] in
      print($0.timeInterval)
      self?.percentTimeCompete -= CGFloat(0.001)
    })
  }
  
  private func restartTimer() {
    timer.invalidate()
    percentTimeCompete = maxTime
    configureTimer()
  }
}
