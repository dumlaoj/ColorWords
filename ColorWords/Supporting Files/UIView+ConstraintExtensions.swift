//
//  UIView+ConstraintExtension.swift
//
//  Created by Jordan Dumlao on 1/7/19.
//  Edited on 1/19/19
//  Copyright © 2019 Jordan Dumlao. All rights reserved.
//
//  Extensions to easily add common cases of constraints
//  This can help reduce bloated code required to
//  Programmatically constrain views
//

import UIKit

extension UIView {
  
  func constrain(leading: NSLayoutXAxisAnchor?, top: NSLayoutYAxisAnchor?, trailing: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, withInset inset: UIEdgeInsets) {
    if let lead = leading { self.leadingAnchor.constraint(equalTo: lead, constant: inset.left).isActive = true }
    if let top = top { self.topAnchor.constraint(equalTo: top, constant: inset.top).isActive = true }
    if let trail = trailing { self.trailingAnchor.constraint(equalTo: trail, constant: -inset.right).isActive = true }
    if let bot = bottom { self.bottomAnchor.constraint(equalTo: bot, constant: -inset.bottom).isActive = true }
  }
  
  func constrain(to view: UIView, withInset inset: UIEdgeInsets) {
    constrain(leading: view.leadingAnchor, top: view.topAnchor, trailing: view.trailingAnchor, bottom: view.bottomAnchor, withInset: inset)
  }
  
  func fillSuperview() {
    guard let sView = self.superview else { return }
    constrain(to: sView, withInset: .zero)
  }
  
  func fillSuperView(_ inset: UIEdgeInsets) {
    guard let sView = self.superview else { return }
    constrain(to: sView, withInset: inset)
  }
  
  func connectBottom(toTopOf topView: UIView, withPadding padding: CGFloat) {
    guard self.superview == topView.superview else { fatalError("Both views must be in the same superview")}
    self.bottomAnchor.constraint(equalTo: topView.topAnchor, constant: padding).isActive = true
  }
  
  func connectTop(toBottomOf botView: UIView, withPadding padding: CGFloat) {
    guard self.superview == botView.superview else { fatalError("Both views must be in the same superview")}
    self.bottomAnchor.constraint(equalTo: botView.topAnchor, constant: padding).isActive = true
  }
  
  func connectLeading(toTrailingOf traillingView: UIView, withPadding padding: CGFloat) {
    guard self.superview == traillingView.superview else { fatalError("Both views must be in the same superview")}
    self.bottomAnchor.constraint(equalTo: traillingView.topAnchor, constant: padding).isActive = true
  }
  
  func connectTrailing(toLeadingOf leadingView: UIView, withPadding padding: CGFloat) {
    guard self.superview == leadingView.superview else { fatalError("Both views must be in the same superview")}
    self.bottomAnchor.constraint(equalTo: leadingView.topAnchor, constant: padding).isActive = true
  }
  
  func anchorSize(_ size: CGSize) {
    self.setHeightTo(size.height)
    self.setWidthTo(size.width)
  }
  
  func setHeightTo(_ height: CGFloat) {
    self.heightAnchor.constraint(equalToConstant: height).isActive = true
  }
  
  func setWidthTo(_ width: CGFloat) {
    self.widthAnchor.constraint(equalToConstant: width).isActive = true
  }
  
  func allignVerticallyTo(_ view: UIView, _ constant: CGFloat) {
    self.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: constant).isActive = true
  }
  
  func allignHorizontallyTo(_ view: UIView, _ constant: CGFloat) {
    self.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: constant).isActive = true
  }
  
  func centerInSuperView() {
    guard let sView = superview else { fatalError("No Superview") }
    allignHorizontallyTo(sView, 0)
    allignVerticallyTo(sView, 0)
  }
  
  func removeAllConstraints() {
    self.removeConstraints(self.constraints)
  }
  
  public convenience init(withBackgroundColor color: UIColor, autoLayout: Bool) {
    self.init()
    self.backgroundColor = color
    self.translatesAutoresizingMaskIntoConstraints = !autoLayout
  }
}

