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
			//guard let colorWord = self.colorWord else { return }
			gameView.colorWordLabel.text = colorWord!.name.rawValue.uppercased()
			gameView.colorWordLabel.textColor = colorWord!.color.color
			gameView.timedProgressView.trackTintColor = colorWord!.color.color
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
	var displayLink: CADisplayLink?
	
	private var rightSwipe: UISwipeGestureRecognizer?
	private var leftSwipe: UISwipeGestureRecognizer?
	
}

//MARK: GAME STATE
extension GameViewController {
	private func startNewGame() {
		points = 0
		addSwipeGestures()
		colorWord = ColorWord()
		resetFlag = true
	}
	
	private func endGame() {
		removeDisplayLink()
		gameView.removeGestureRecognizer(rightSwipe!)
		gameView.removeGestureRecognizer(leftSwipe!)
		print("GAME OVER")
		//TODO: DISPLAY GAME OVER
		presentGameOverView() 
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
		self.colorWord = ColorWord()
		resetFlag = true
	}
}

//MARK: TIMER USING CADISPLAY LINK
//MARK: CAN MAKE THIS OWN CONTROLLER
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
			print(self.children.count)
		}
		gameView.addSubview(goViewController.view)
		addChild(goViewController)
		print(children.count)
		goViewController.didMove(toParent: self)
		
	}
}
