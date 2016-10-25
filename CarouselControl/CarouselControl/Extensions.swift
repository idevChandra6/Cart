//
//  Extensions.swift
//  Carousel
//
//  Created by Ziaurehman Amini on 9/29/16.
//  Copyright © 2016 Visa. All rights reserved.
//

import Foundation

// MARK:- Autolayout
extension UIView {
    func boundInside(superView: UIView){
        self.translatesAutoresizingMaskIntoConstraints = false
        superView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[subview]-0-|", options: NSLayoutFormatOptions.directionLeadingToTrailing, metrics:nil, views:["subview":self]))
        superView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[subview]-0-|", options: NSLayoutFormatOptions.directionLeadingToTrailing, metrics:nil, views:["subview":self]))
    }
}
