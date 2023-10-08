//
//  UIView+PinnedSubview.swift
//  Today
//
//  Created by Ibukunoluwa Akintobi on 27/09/2023.
//
import UIKit
import Foundation


extension UIView {
    func addPinnedSubview(
        _ subview: UIView, height: CGFloat? = nil,
    insets: UIEdgeInsets = UIEdgeInsets(top:0, left:8, bottom:0, right:8)) {
        addSubview(subview)
        subview.translatesAutoresizingMaskIntoConstraints = false
        ///The UIKit constraint syntax allows you to define and activate a constraint in a single step by setting the isActive property of a new constraint to true.
        subview.topAnchor.constraint(equalTo: topAnchor,constant: insets.left).isActive = true
        subview.leadingAnchor.constraint(equalTo:leadingAnchor,constant: insets.left).isActive = true
        subview.trailingAnchor.constraint(equalTo:trailingAnchor,constant: -1.0 * insets.right).isActive = true
        subview.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -1.0 * insets.bottom).isActive = true
        if let height {
            subview.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
}
