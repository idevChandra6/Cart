//
//  BadgeButton.swift
//  EverywhereShop
//
//  Created by Yang, May on 9/18/15.
//  Copyright © 2015 Jain, Vijay. All rights reserved.
//

import Foundation
import UIKit

class BadgeButton: UIButton
{
    var customBadge = CustomBadge()
    var badgeNumber:Int = 0
    
    init()
    {
        super.init(frame: CGRect.zero)
        self.customBadge = CustomBadge.aCustomBadge(with: "")
    }

    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        self.customBadge = CustomBadge.aCustomBadge(with: "")
    }
    
    func incrementBadge()
    {
        self.badgeNumber += 1
        self.setBadge(self.badgeNumber)
    }
    
    func decrementBadge()
    {
        self.badgeNumber -= 1
        self.setBadge(self.badgeNumber)
    }
    
    func setBadge(_ badgeNumber:Int)
    {
        self.customBadge.removeFromSuperview()
        
        if badgeNumber > 0
        {
            self.badgeNumber = badgeNumber
            self.customBadge = CustomBadge.aCustomBadge(with: "\(badgeNumber)")
            self.customBadge.center = CGPoint(x: self.bounds.size.width + 2, y: 4)
            self.customBadge.frame = self.customBadge.frame.integral
            self.customBadge.autoresizingMask = UIViewAutoresizing.flexibleLeftMargin
            self.addSubview(self.customBadge)
        }
    }
}
