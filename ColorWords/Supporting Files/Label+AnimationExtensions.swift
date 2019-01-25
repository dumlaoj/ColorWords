//
//  Label+AnimationExtensions.swift
//  ColorWords
//
//  Created by Jordan Dumlao on 1/25/19.
//  Copyright © 2019 Jordan Dumlao. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
	func pulsate() {
		let scale: CGFloat = 1.2
		let duration: TimeInterval = 0.1
		let pulsingAnimation = UIViewPropertyAnimator(duration: duration, curve: .linear, animations: {
			self.transform = CGAffineTransform(scaleX: scale, y: scale)
		})
		pulsingAnimation.addCompletion { _ in
			let pulseCompletion = UIViewPropertyAnimator(duration: duration, curve: .linear, animations: {
				self.transform = .identity
			})
			pulseCompletion.startAnimation()
		}
		pulsingAnimation.startAnimation()		
	}
}
