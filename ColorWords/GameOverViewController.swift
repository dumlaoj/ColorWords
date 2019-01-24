//
//  GameOverViewController.swift
//  ColorWords
//
//  Created by Jordan Dumlao on 1/23/19.
//  Copyright © 2019 Jordan Dumlao. All rights reserved.
//

import UIKit

class GameOverViewController: UIViewController {

	var gameOverView: BlurredPopupView?
	var completion: ( () -> Void )?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		gameOverView = BlurredPopupView(labelText: "GAME OVER", cornerRadius: 20.0, blurStyle: .light)
		if let completion = self.completion {
			gameOverView?.completionOnTap = completion
		}
		view.addSubview(gameOverView!)
	}
}
