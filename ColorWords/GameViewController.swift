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
	var previousColorWord: ColorWord?
	var colorWord: ColorWord? {
		didSet {
			gameView.colorWordLabel.text = colorWord!.name.rawValue.uppercased()
			gameView.colorWordLabel.textColor = colorWord!.color.color
			gameView.timedProgressView.trackTintColor = colorWord!.color.color
		}
	}
	
	var points: Int = 0 {
		didSet {
			gameView.pointsLabel.pulsate()
			gameView.pointsLabel.text = "\(points)"
			speedUpTime()
		}
	}
	
	var resetFlag: Bool = true {
		didSet {
			if resetFlag {
				gameView.timedProgressView.setProgress(0, animated: false)
				//restartDisplayLink()
				timer.restartTimer()
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
	let initialMaxTime: Float = 3.0
	var maxTime: Float = 3.0
	var percentComplete: Float { return Float(elapsedTime / maxTime) }
	var timer = CADLTimer()
//
//	var displayLink: CADisplayLink?
//	var animationStartDate = Date()
//
	private var rightSwipe: UISwipeGestureRecognizer?
	private var leftSwipe: UISwipeGestureRecognizer?
	
}

//MARK: GAME STATE
extension GameViewController {
	private func startNewGame() {
		points = 0
		maxTime = initialMaxTime
		addSwipeGestures()
		colorWord = ColorWord()
		resetFlag = true
	}
	
	private func endGame() {
		//removeDisplayLink()
		timer.stopTimer()
		gameView.removeGestureRecognizer(rightSwipe!)
		gameView.removeGestureRecognizer(leftSwipe!)
		presentGameOverView() 
	}
	
	private func speedUpTime() {
		switch points {
		case 05, 10, 15, 20, 25, 30, 35, 40, 45, 50:
			maxTime = maxTime * 0.85
		default: break
		}
	}
}

//MARK: View Lifecycle
extension GameViewController {
	
	override func loadView() {
		super.loadView()
		let gameView = GameView(frame: UIScreen.main.bounds)
		view = gameView
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		startNewGame()
		gameView.timedProgressView.transform = CGAffineTransform(scaleX: -1.0, y: 1.0);
		
		timer.delegate = self
	}
	
	private func wasSwiped(inDirection direction: UISwipeGestureRecognizer.Direction) {
		guard let colorWord = self.colorWord else { return }
		switch direction {
		case .right:
			guard colorWord.isCorrect else { endGame(); return }
			updatePointsAndColorWord()
		case .left:
			guard !colorWord.isCorrect else { endGame(); return }
			updatePointsAndColorWord()
		default: break
		}
	}
	
	private func updatePointsAndColorWord() {
		points += 1
		previousColorWord = colorWord
//		var newColorWord = ColorWord()
//		while newColorWord == previousColorWord {
//			print("colorWord is the same")
//			newColorWord = ColorWord()
//		}
		colorWord = generateNewColor(notTheSameAs: previousColorWord!)
		resetFlag = true
	}
	
	func generateNewColor(notTheSameAs previousColor: ColorWord) -> ColorWord {
		
		let newColorWord = ColorWord()
		if newColorWord != previousColor {
			return newColorWord
		} else {
			return self.generateNewColor(notTheSameAs: previousColor)
		}
	}
}

//GESTURES
extension GameViewController {
	private func addSwipeGestures() {
		rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
		rightSwipe!.direction = .right
		gameView.addGestureRecognizer(rightSwipe!)
	
		leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
		leftSwipe!.direction = .left
		gameView.addGestureRecognizer(leftSwipe!)
	}
	
	@objc private func handleSwipe(_ sender: UISwipeGestureRecognizer) {
		switch sender.state {
		case .ended:
			switch sender {
			case rightSwipe: wasSwiped(inDirection: .right)
			case leftSwipe: wasSwiped(inDirection: .left)
			default: break
			}
		default:
			break
		}
	}
	
	func presentGameOverView() {
		let goViewController = GameOverViewController()
		goViewController.completion = {
			goViewController.willMove(toParent: nil)
			goViewController.removeFromParent()
			goViewController.view.removeFromSuperview()
			self.startNewGame()
		}
		gameView.addSubview(goViewController.view)
		addChild(goViewController)
		goViewController.didMove(toParent: self)
	}
}

//MARK: TIMER USING CADISPLAY LINK
//MARK: CAN MAKE THIS OWN CONTROLLER
extension GameViewController: CADLTimerDelegate {

	func cadltimer(_ cadltimer: CADLTimer, didUpdateWithTimerInterval timeInterval: TimeInterval) {
		elapsedTime = Float(timeInterval)
	}
}


//
//
//	func restartDisplayLink() {
//		removeDisplayLink()
//		addDisplayLink()
//	}
//
//	func addDisplayLink() {
//		animationStartDate = Date()
//		displayLink = CADisplayLink(target: self, selector: #selector(handleUpdate(displayLink:)))
//		displayLink?.add(to: .main, forMode: .default)
//	}
//
//	func removeDisplayLink() {
//		displayLink?.invalidate()
//		displayLink = nil
//	}
//
//	@objc func handleUpdate(displayLink: CADisplayLink) {
//		let now = Date()
//		elapsedTime = Float(now.timeIntervalSince(animationStartDate))
//	}
