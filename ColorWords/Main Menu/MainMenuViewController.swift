//
//  MainMenuViewController.swift
//  ColorWords
//
//  Created by Jordan Dumlao on 1/24/19.
//  Copyright © 2019 Jordan Dumlao. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController {
	
	var mainMenuView: MainMenuView { return view as! MainMenuView }
	var cardMenuVC = CardMenuViewController()
	var cardView: UIView { return cardMenuVC.view }
	var heightForExpandedCardView: CGFloat {
		return view.frame.height / 3
	}
	
	//	VARIABLES FOR EXPANDED CARD VIEW
	enum CardState {
		case expand
		case collapse
	}
	
	var isVisible = false
	var nextState: CardState { return isVisible ? .collapse : .expand }
	var runningAnimators = [UIViewPropertyAnimator]()
	var animationProgressBeforeInterruption: CGFloat = 0
	
	override func loadView() {
		super.loadView()
		let mainMenuView = MainMenuView(frame: UIScreen.main.bounds)
		view = mainMenuView
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.backgroundColor = .white
		configureCardViewMenu()
		configureGestures()
		
	}
	
	private func configureCardViewMenu() {
		addChild(cardMenuVC)
		view.addSubview(cardMenuVC.view)
		cardMenuVC.didMove(toParent: self)
		
		cardView.frame = CGRect(x: view.frame.origin.x, y: view.frame.maxY, width: view.frame.width, height: heightForExpandedCardView)
		cardView.clipsToBounds = true
		cardView.layer.cornerRadius = 20
		cardView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
		
	}
	
	private func configureGestures() {
		let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
		cardMenuVC.handleView.addGestureRecognizer(pan)
		mainMenuView.button.addTarget(self, action: #selector(handleTap(_:)), for: .touchUpInside)
	}
	
	@objc private func handleTap(_ recognizer: UITapGestureRecognizer? = nil) {
		//animateTransitionIfNeeded(forState: nextState, duration: 1.0)
		
		// TRANSITION TO GAME VIEW CONTROLLER HERE
		let gameVC = GameViewController()
		navigationController?.pushViewController(gameVC, animated: true)
	}
	
	@objc private func handlePan(_ recognizer: UIPanGestureRecognizer) {
		switch recognizer.state {
		case .began:
			startTransition(forState: nextState, duration: 1.0)
		case .changed:
			let translation = recognizer.translation(in: cardMenuVC.handleView)
			var fractionComplete = translation.y / heightForExpandedCardView
			fractionComplete = nextState == .expand ? -fractionComplete : fractionComplete
			updateTransition(fractionComplete: fractionComplete)
		case .ended:
			continueInteraction()
			break
		default:
			break
		}
	}
	
	private func animateTransitionIfNeeded(forState state: CardState, duration: TimeInterval) {
		//	PERFORM ALL ANIMATIONS IF NOT ALREADY RUNNING
		guard runningAnimators.isEmpty else { return }
		
		let frameAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 0.8) {
			switch self.nextState {
			case .expand:
				self.cardView.frame.origin.y = self.view.frame.size.height - self.heightForExpandedCardView
				
			case .collapse:
				self.cardView.frame.origin.y = self.view.frame.maxY
			}
		}
		
		frameAnimator.addCompletion { _ in
			self.isVisible.toggle()
			self.runningAnimators.removeAll()
		}
		
		frameAnimator.startAnimation()
		runningAnimators.append(frameAnimator)
	}
	
	private func startTransition(forState state: CardState, duration: TimeInterval) {
		if runningAnimators.isEmpty {
			animateTransitionIfNeeded(forState: nextState, duration: duration)
		}
		
		runningAnimators.forEach {
			$0.pauseAnimation()
			animationProgressBeforeInterruption = $0.fractionComplete
		}
	}
	
	private func updateTransition(fractionComplete: CGFloat) {
		runningAnimators.forEach { $0.fractionComplete = fractionComplete }
	}
	
	private func continueInteraction() {
		runningAnimators.forEach { $0.continueAnimation(withTimingParameters: nil, durationFactor: 0)}
	}
	
	
}
