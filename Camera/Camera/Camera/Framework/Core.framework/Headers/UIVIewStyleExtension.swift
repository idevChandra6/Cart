//
//  UIVIewStyleExtension.swift
//  OneMarket
//
//  Created by Jain, Vijay on 6/12/15.
//  Copyright (c) 2015 VISA. All rights reserved.
//

import UIKit

extension UIView
{
    func setStyle(_ styleName:String)
    {
        if let styleDictionary = ConfiguredStyle.sharedInstance.styles
        {
            if let style = styleDictionary[styleName] as? NSDictionary
            {
                if styleName == "VerticalGradientBackground"
                {
                    var colors = [CGColor]()
                    if let bottomColorString = style["bottomColor"] as? String
                    {
                        if let color = UIColor.colorWithHexString(bottomColorString)?.cgColor
                        {
                            colors.append(color)
                        }
                    }
                    if let topColorString = style["topColor"] as? String
                    {
                        if let color = UIColor.colorWithHexString(topColorString)?.cgColor
                        {
                            colors.append(color)
                        }
                    }
                    let gradientLayer = CAGradientLayer()
                    let frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height);
                    gradientLayer.frame = frame;
                    gradientLayer.colors = colors;
                    self.layer.insertSublayer(gradientLayer, at:0)
                }
                else if styleName == "HorizontalGradientBackground"
                {
                    var colors = [CGColor]()
                    if let leftColorString = style["leftColor"] as? String
                    {
                        if let color = UIColor.colorWithHexString(leftColorString)?.cgColor
                        {
                            colors.append(color)
                        }
                    }
                    if let rightColorString = style["rightColor"] as? String
                    {
                        if let color = UIColor.colorWithHexString(rightColorString)?.cgColor
                        {
                            colors.append(color)
                        }
                    }
                    let gradientLayer = CAGradientLayer()
                    let frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height);
                    gradientLayer.frame = frame;
                    gradientLayer.colors = colors;
                    gradientLayer.startPoint = CGPoint(x: 0, y: 0.5);
                    gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5);
                    self.layer.insertSublayer(gradientLayer, at:0)
                }
                else if styleName == "DiagonalGradientBackground"
                {
                    var colors = [CGColor]()
                    if let diagonalBottomColorString = style["bottomLeftColor"] as? String
                    {
                        if let color = UIColor.colorWithHexString(diagonalBottomColorString)?.cgColor
                        {
                            colors.append(color)
                        }

                    }
                    if let topRightColorString = style["topRightColor"] as? String
                    {
                        if let color = UIColor.colorWithHexString(topRightColorString)?.cgColor
                        {
                            colors.append(color)
                        }
                    }
                    let gradientLayer = CAGradientLayer()
                    let frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height);
                    gradientLayer.frame = frame;
                    gradientLayer.colors = colors;
                    gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0);
                    gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.0);
                    self.layer.insertSublayer(gradientLayer, at:0)

                }
            }
        }
    }
}


