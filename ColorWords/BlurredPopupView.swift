//
//  BlurredPopupView.swift
//  PopupVisualBlur
//
//  Created by Jordan Dumlao on 1/21/19.
//  Copyright © 2019 Jordan Dumlao. All rights reserved.
//

import UIKit

class BlurredPopupView: UIView {
  
  private var blurredView: UIVisualEffectView = {
    let visEffView = UIVisualEffectView(backgroundColor: .clear, cornerRadius: nil)
    return visEffView
  }()
  
  private var nestedView: UIView = {
    let view = UIView(backgroundColor: UIColor(white: 1, alpha: 0.7), cornerRadius: 10.0)
    return view
  }()
  
  private var label: UILabel = {
    let label = UILabel(backgroundColor: .clear, cornerRadius: nil)
    label.textAlignment = .center
    label.font = UIFont.boldSystemFont(ofSize: 30.0)
    label.adjustsFontSizeToFitWidth = true
    return label
  }()
  
  var blurEffect = UIBlurEffect(style: .light)
  var text: String? {
    get {
      return label.text
    } set {
      label.text = newValue
    }
  }
  
  var containerViewBackgroundColor: UIColor? {
    get {
      return nestedView.backgroundColor
    }
    set {
      nestedView.backgroundColor = newValue
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    renderViews()
  }
  
  required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
  
  private func renderViews() {
    
  }
  
  func animatePopup() {
    
    addSubview(blurredView)
    blurredView.fillSuperview()
    blurredView.contentView.addSubview(nestedView)
    
    nestedView.constrain(withSize: CGSize(width: 200, height: 200))
    nestedView.centerInSuperView()
    
    label.text = text
    nestedView.addSubview(label)
    label.fillSuperview()
    
    nestedView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
    nestedView.alpha = 0
    
    nestedView.isHidden = false
    label.isHidden = false
    
    blurredView.effect = self.blurEffect
    
    UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 1 , options: .curveEaseOut, animations: { [weak self] in
      guard let self = self else { return }

      self.nestedView.transform = .identity
      self.nestedView.alpha = 1
    })
  }
  
  func removePopup() {
    UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveLinear, animations: { [weak self] in
      guard let self = self else { return }
      self.label.isHidden = true
      self.nestedView.alpha = 0
      self.nestedView.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
      self.blurredView.effect = nil

      }, completion: { [weak self] _ in
        guard let self = self else { return }
        
        self.label.isHidden = true
        self.nestedView.isHidden = true
    })
  }
}
