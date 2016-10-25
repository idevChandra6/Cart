//
//  UIImageRoundedExtension.swift
//  Core
//
//  Created by Yang, May on 10/15/15.
//  Copyright © 2015 Visa Inc. All rights reserved.
//

import Foundation
import QuartzCore

extension UIImageView
{
//    var circle: UIImage
//        {
//        let square = size.width < size.height ? CGSize(width: size.width, height: size.width) : CGSize(width: size.height, height: size.height)
//        let imageView = UIImageView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: square))
//        imageView.contentMode = UIViewContentMode.ScaleAspectFill
//        imageView.image = self
//        imageView.layer.cornerRadius = square.width/2
//        imageView.layer.masksToBounds = true
//        UIGraphicsBeginImageContext(imageView.bounds.size)
//        imageView.layer.renderInContext(UIGraphicsGetCurrentContext()!)
//        let result = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//        return result
//    }
//    
//    class func imageWithColor(color:UIColor) -> UIImage!
//    {
//        let rect = CGRectMake(0, 0, 1, 1)
//        UIGraphicsBeginImageContext(rect.size)
//        let context = UIGraphicsGetCurrentContext()
//        CGContextSetFillColorWithColor(context, color.CGColor)
//        CGContextFillRect(context, rect)
//        let image = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//        return image
//    }
    
    class func roundImageView(_ imageView:UIView)
    {
        imageView.layer.borderWidth = 0.0
        imageView.layer.masksToBounds = false
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.cornerRadius = (imageView.frame.size.width)/2
        imageView.clipsToBounds = true
    }
}
