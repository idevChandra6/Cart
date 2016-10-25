//
//  UIImageColorExtension.swift
//  OneMarket
//
//  Created by Jain, Vijay on 7/16/15.
//  Copyright (c) 2015 VISA. All rights reserved.
//

import UIKit

extension UIImage
{
    class func imageWithColor(_ color:UIColor) -> UIImage!
    {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
