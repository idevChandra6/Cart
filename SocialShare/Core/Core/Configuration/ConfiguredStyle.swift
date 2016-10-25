//
//  ConfiguredStyle.swift
//  OneMarket
//
//  Created by Jain, Vijay on 6/12/15.
//  Copyright (c) 2015 VISA. All rights reserved.
//

import UIKit

class ConfiguredStyle: NSObject
{
    static let  sharedInstance = ConfiguredStyle()
    
    fileprivate var styleDictionary: NSDictionary?
    
    private override init()
    {
        if let plistPath = Bundle.main.path(forResource: "Style", ofType: "plist")
        {
            self.styleDictionary = NSDictionary(contentsOfFile: plistPath)
        }
    }
    
    var styles:NSDictionary?
    {
        get {
            if Device.isiPhone6Or6S()
            {
                return self.styleDictionary?["iPhone6OrAbove"] as? NSDictionary
            }
            else
            {
                return self.styleDictionary?["iPhone5SOrBelow"] as? NSDictionary
            }
        }
    }
    
}
