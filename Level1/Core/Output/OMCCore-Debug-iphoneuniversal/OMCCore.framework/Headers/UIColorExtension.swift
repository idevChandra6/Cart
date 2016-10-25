//
//  UIColorExtension.swift
//  OneMarket
//
//  Created by Jain, Vijay on 6/12/15.
//  Copyright (c) 2015 VISA. All rights reserved.
//

import UIKit

extension UIColor
{
    public class func colorWithHexString(_ hexString:String, alpha:Float=1.0) -> UIColor?
    {
        var hex = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        
        for prefix in ["#", "0X"]
        {
            if (hex.hasPrefix(prefix) == true)
            {
                if let index = hex.range(of: prefix)
                {
                    hex = hex.substring(with: index)
                }
            }
        }
        
        if (hex.characters.count < 6)
        {
            return nil;
        }

        let range1 = hex.startIndex..<hex.index(hex.startIndex, offsetBy:2)
        let redString = hex.substring(with: range1)

        let range2 = hex.index(hex.startIndex, offsetBy:2)..<hex.index(hex.startIndex, offsetBy:4)
        let greenString = hex.substring(with: range2)

        let range3 = hex.index(hex.startIndex, offsetBy:4)..<hex.index(hex.startIndex, offsetBy:6)
        let blueString = hex.substring(with: range3)

        var red:UInt32 = 0
        var green:UInt32 = 0
        var blue:UInt32 = 0
        
        Scanner(string:redString).scanHexInt32(&red)
        Scanner(string:greenString).scanHexInt32(&green)
        Scanner(string:blueString).scanHexInt32(&blue)

        return UIColor(red:CGFloat(red)/255.0, green:CGFloat(green)/255.0, blue:CGFloat(blue)/255.0, alpha:CGFloat(alpha))
    }
    
    class func defaultBackgroundBlueColor() -> UIColor
    {
        return UIColor(red: 9/255, green: 79/255, blue: 163/255, alpha: 1.0)
    }
    
    class func defaultBackgroundLightBlueColor() -> UIColor
    {
        return UIColor(red: 14/255, green: 147/255, blue: 211/255, alpha: 1.0)
    }
    
    class func deepSeaBlueColor() -> UIColor
    {
        return UIColor(red: 5/255, green: 87/255, blue: 128/255, alpha: 1.0)
    }
    
    class func sunFlowerYellow() -> UIColor
    {
        return UIColor(red: 255/255, green: 206/255, blue: 0/255, alpha: 1.0)
    }
    
    class func alertTextColor() -> UIColor
    {
        return UIColor(red: 208/255, green: 2/255, blue: 27/255, alpha: 1.0)
    }


}
