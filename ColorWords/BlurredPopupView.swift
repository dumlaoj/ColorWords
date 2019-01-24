//
//  BlurredPopupView.swift
//  PopupVisualBlur
//
//  Created by Jordan Dumlao on 1/21/19.
//  Copyright © 2019 Jordan Dumlao. All rights reserved.
//

import UIKit

class BlurredPopupView: UIView {
	
	private var blurredView = UIVisualEffectView(backgroundColor: .clear, cornerRadius: nil)
	private var containerView = UIView()
	
	private var label: UILabel = {
		let label = UILabel(backgroundColor: .clear, cornerRadius: nil)
		label.textAlignment = .center
		label.font = UIFont.boldSystemFont(ofSize: 30.0)
		label.adjustsFontSizeToFitWidth = true
		return label
	}()
	
	private var tapGesture: UITapGestureRecognizer?
	
	var completionOnTap: ( () -> Void )?
	
	
	var blurEffect = UIBlurEffect()
	
	var text: String? {
		get {
			return label.text
		} set {
			label.text = newValue
		}
	}
	
	var containerViewBackgroundColor: UIColor? {
		get {
			return containerView.backgroundColor
		}
		set {
			containerView.backgroundColor = newValue
		}
	}
	
	var containerCornerRadius: CGFloat {
		get {
			return containerView.layer.cornerRadius
		}
		set {
			containerView.layer.cornerRadius = newValue
		}
	}
	
	@objc private func handleTap(_ sender: UITapGestureRecognizer) {
		switch sender.state {
		case .ended:
			removePopup()
		default:
			break
		}
	}
	
	private override init(frame: CGRect) {
		super.init(frame: frame)
	}
	
	convenience init(labelText: String, cornerRadius: CGFloat, blurStyle: UIBlurEffect.Style, backgroundColor: UIColor = .clear) {
		self.init()
		//DO SOMETHING
		text = labelText
		containerCornerRadius = cornerRadius
		blurEffect = UIBlurEffect(style: blurStyle)
		containerViewBackgroundColor = backgroundColor
	}
	
	required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
	
	override func didMoveToSuperview() {
		//render views here
		self.fillSuperview()
		animatePopup()
	}
	
	private func animatePopup() {
		
		//ADD AND CONFIGURE BLURRED VIEW
		addSubview(blurredView)
		blurredView.fillSuperview()
		blurredView.effect = blurEffect
		
		//ADD AND CONFIGURE CONTAINER VIEW
		blurredView.contentView.addSubview(containerView)
		containerView.constrain(withSize: CGSize(width: 200, height: 200))
		containerView.centerInSuperView()
		
		//ADD AND CONFIGURE LABEL
		containerView.addSubview(label)
		label.fillSuperview()
		
		//HIDE AND MINIMIZE CONTAINER VIEW
		containerView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
		containerView.alpha = 0
		
		//RE-SHOW CONTAINER AND LABEL IF HIDDEN
//		containerView.isHidden = false
//		label.isHidden = false
		
		tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
		
		UIView.animate(withDuration: 1.0, delay: 0.5, usingSpringWithDamping: 0.4, initialSpringVelocity: 1 , options: .curveEaseOut, animations: { [weak self] in
			guard let self = self else { return }
			self.containerView.transform = .identity
			self.containerView.alpha = 1
			}, completion: { _ in
				if let tap = self.tapGesture {
					self.addGestureRecognizer(tap)
				}
		})
	}
	
	private func removePopup() {
		UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 1, options: .curveLinear, animations: { [weak self] in
			guard let self = self else { return }
			let transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
			self.label.alpha = 0
			self.containerView.alpha = 0
			self.blurredView.alpha = 0
			
			self.containerView.transform = transform
			self.label.transform = transform
			}, completion: { [weak self] _ in
				guard let self = self else { return }
				self.label.isHidden = true
				self.containerView.isHidden = true
				if let tap = self.tapGesture {
					self.removeGestureRecognizer(tap)
				}
				self.removeFromSuperview()
				if let completionBlock = self.completionOnTap {
					completionBlock()
				}
				
		})
	}
}
