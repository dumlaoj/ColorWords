//
//  CADLTimer.swift
//  ColorWords
//
//  Created by Jordan Dumlao on 1/24/19.
//  Copyright © 2019 Jordan Dumlao. All rights reserved.
//

import Foundation
import UIKit

/*
TIMER USING CA DISPLAY LINK
*/

protocol CADLTimerDelegate: class {
	func cadltimer(_ cadltimer: CADLTimer, didUpdateWithTimerInterval timeInterval: TimeInterval)
}

class CADLTimer {
	
	weak var delegate: CADLTimerDelegate?
	private var displayLink: CADisplayLink?
	private var startTime: Date?
	private var timeIntervalSinceStart: TimeInterval?
	
	init() {
		
	}
	
	func startTimer() {
		addDisplayLink()
	}
	
	func stopTimer() {
		removeDisplayLink()
	}
	
	func restartTimer() {
		removeDisplayLink()
		addDisplayLink()
	}
	
	private func removeDisplayLink() {
		displayLink?.invalidate()
		displayLink = nil
	}
	
	private func addDisplayLink() {
		startTime = Date()
		displayLink = CADisplayLink(target: self, selector: #selector(handle(_:)))
		displayLink?.add(to: .main, forMode: .default)
	}
	
	@objc func handle(_ displayLink: CADisplayLink) {
		let currentDate = Date()
		timeIntervalSinceStart = currentDate.timeIntervalSince(startTime!)
		delegate?.cadltimer(self, didUpdateWithTimerInterval: timeIntervalSinceStart!)
	}
}
//
//
//
//extension GameViewController {
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
//}
