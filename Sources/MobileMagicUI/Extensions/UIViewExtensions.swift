//
//  File.swift
//  
//
//  Created by Evandro Harrison Hoffmann on 17/08/2021.
//

import UIKit

public extension UIView {
    func addShadow(color: CGColor = UIColor.black.cgColor,
                   opacity: Float = 1,
                   radius: CGFloat = 1,
                   offset: CGSize = .zero) {
        clipsToBounds = false
        layer.shadowColor = color
        layer.shadowOpacity = opacity
        layer.shadowRadius = radius
        layer.shadowOffset = offset
    }
}

public extension UIView {
    func roundTopCorners(radius: CGFloat = 8) {
        clipsToBounds = true
        layer.cornerRadius = radius
        if #available(iOS 11.0, *) {
            layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        } else {
            roundCorners(corners: [.topLeft, .topRight], radius: radius)
        }
    }
    
    func roundBottomCorners(radius: CGFloat = 8) {
        self.clipsToBounds = true
        self.layer.cornerRadius = radius
        if #available(iOS 11.0, *) {
            layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        } else {
            roundCorners(corners: [.bottomLeft, .bottomRight], radius: radius)
        }
    }
    
    private func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    func unroundCorners() {
        layer.maskedCorners = []
        layer.mask = nil
    }
}
