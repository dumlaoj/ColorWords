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

  var gameView: GameView {
    return view as! GameView
  }
  
  override func loadView() {
    super.loadView()
    let gameView = GameView(frame: UIScreen.main.bounds)
    gameView.delegate = self
    view = gameView
  }
}

//MARK: View Lifecycle
extension GameViewController {
  override func viewDidLoad() {
    super.viewDidLoad()

  }
}

extension GameViewController: GameViewDelegate {
  func gameView(_ gameView: GameView, wasSwipedInDirection swipe: UISwipeGestureRecognizer.Direction) {
    //TODO: Do something when swiped
    switch swipe {
    case .right: break
    case .left: break
    default: break
    }
  }
}

extension ColorWord {
  var color: UIColor {
    switch self.colorFromIndex {
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
