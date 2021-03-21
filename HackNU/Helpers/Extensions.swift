//
//  Extensions.swift
//  HackNU
//
//  Created by Adlet Zeineken on 20.03.2021.
//  Copyright © 2021 justadlet. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

extension UIImageView {
    func setImage(from url: URL?){
        self.sd_setImage(with: url, placeholderImage: UIImage(named: "AppIcon"), options: .refreshCached, context: nil)
    }

}

extension UIView {
    func addConstraint(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, trailing: NSLayoutXAxisAnchor?,
                       centerXAnchor: NSLayoutXAxisAnchor?, centerYAnchor: NSLayoutYAxisAnchor?,
                       paddingTop: CGFloat = 0, paddingLeading: CGFloat = 0, paddingBottom: CGFloat = 0, paddingTrailing: CGFloat = 0,
                       width: CGFloat = 0, height: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        if let leading = leading {
            self.leadingAnchor.constraint(equalTo: leading, constant: paddingLeading).isActive = true
        }
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: bottom, constant: paddingBottom).isActive = true
        }
        if let trailing = trailing {
            self.trailingAnchor.constraint(equalTo: trailing, constant: paddingTrailing).isActive = true
        }
        if let centerYTo = centerYAnchor {
            self.centerYAnchor.constraint(equalTo: centerYTo).isActive = true
        }
        if let centerXTo = centerXAnchor {
            self.centerXAnchor.constraint(equalTo: centerXTo).isActive = true
        }
        
        if width != 0 {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        if height != 0 {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
}

extension UITextField {
    func activate() {
        layer.borderColor = Color.blue.cgColor
    }
    func deactivate() {
        layer.borderColor = Color.lightBorder.cgColor
    }
}

extension Date {
    func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
        return calendar.dateComponents(Set(components), from: self)
    }

    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
}
