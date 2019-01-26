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
		//button.setTitle("Play", for: .normal)
		//button.backgroundColor = .flatSkyBlue
		let font = UIFont.systemFont(ofSize: 75, weight: .bold)
		let attributedString = NSAttributedString(string: "PLAY", attributes: [.font: font])
		button.setAttributedTitle(attributedString, for: .normal)
		button.clipsToBounds = true
		return button
	}()
//
//	let label = UILabel(backgroundColor: .clear, textLabel: "COLOR")
//	label.textAlignment = .center
//	label.textColor = .flatBlack
//	label.font = UIFont.boldSystemFont(ofSize: 75)
//	return label
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		backgroundColor = .white
		renderViews()
		
	}
	
	required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
	
	private func renderViews() {
		addSubview(button)
		let buttonHeight: CGFloat = 300
		button.constrain(withSize: CGSize(width: buttonHeight, height: buttonHeight))
		button.layer.cornerRadius = buttonHeight / 2
		button.centerInSuperView()
		
	}
}
