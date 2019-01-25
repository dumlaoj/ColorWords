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
	
	override func loadView() {
		super.loadView()
		let mainMenuView = MainMenuView(frame: UIScreen.main.bounds)
		view = mainMenuView
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		
	}
	
	
}
