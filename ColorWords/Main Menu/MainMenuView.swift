//
//  MainMenuView.swift
//  ColorWords
//
//  Created by Jordan Dumlao on 1/24/19.
//  Copyright © 2019 Jordan Dumlao. All rights reserved.
//

import UIKit

class MainMenuView: UIView {
	
	let button: UIButton = {
		let button = UIButton()
		button.setTitle("Play", for: .normal)
		button.backgroundColor = .flatSkyBlue
		button.clipsToBounds = true
		return button
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		backgroundColor = .white
		renderViews()
		
	}
	
	required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
	
	private func renderViews() {
		addSubview(button)
		let buttonHeight: CGFloat = 100
		button.constrain(withSize: CGSize(width: buttonHeight, height: buttonHeight))
		button.layer.cornerRadius = buttonHeight / 2
		button.centerInSuperView()
		
	}
}
