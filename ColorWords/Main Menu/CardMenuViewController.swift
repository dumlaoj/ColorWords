//
//  CardMenuViewController.swift
//  ColorWords
//
//  Created by Jordan Dumlao on 1/25/19.
//  Copyright © 2019 Jordan Dumlao. All rights reserved.
//

import UIKit

class CardMenuViewController: UIViewController {
	
	let handleView = UIView(backgroundColor: .clear, cornerRadius: nil)
	
	let handleBarView = UIView(backgroundColor: .gray, cornerRadius: nil)
	
    override func viewDidLoad() {
        super.viewDidLoad()
		view.backgroundColor = .flatWhiteDark
		
		renderHandleView()
    }
	
	private func renderHandleView() {
		view.addSubview(handleView)
		handleView.constrain(withHeight: 40)
		handleView.constrain(toLeading: view.leadingAnchor, top: view.topAnchor, trailing: view.trailingAnchor, bottom: nil, withPadding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
		handleView.addSubview(handleBarView)
		handleBarView.constrain(withSize: CGSize(width: 40, height: 10))
		handleBarView.layer.cornerRadius = 10 / 2
		handleBarView.clipsToBounds = true
		handleBarView.centerInSuperView()
	}
	
}
