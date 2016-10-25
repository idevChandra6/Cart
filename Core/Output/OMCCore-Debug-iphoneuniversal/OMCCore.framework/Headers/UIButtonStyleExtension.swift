//
//  UIComponentStyleExtension.swift
//  OneMarket
//
//  Created by Jain, Vijay on 6/12/15.
//  Copyright (c) 2015 VISA. All rights reserved.
//

import UIKit

extension UIButton
{
    func setBackgroundColor(_ color: UIColor, forState: UIControlState)
    {
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        UIGraphicsGetCurrentContext()?.setFillColor(color.cgColor)
        UIGraphicsGetCurrentContext()?.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        let colorImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        self.setBackgroundImage(colorImage, for: forState)
    }
    
    

    override func setStyle(_ styleName:String)
    {
        if let styleDictionary = ConfiguredStyle.sharedInstance.styles
        {
            if let style = styleDictionary[styleName] as? NSDictionary
            {
                if let styleCornerRadius = style["cornerRadius"] as? NSString
                {
                    self.layer.cornerRadius = CGFloat(styleCornerRadius.floatValue)
                    self.clipsToBounds = true
                }
            
                if let styleBorder = style["border"] as? NSDictionary
                {
                    if let borderWidth = styleBorder["borderWidth"] as? NSString
                    {
                        self.layer.borderWidth = CGFloat(borderWidth.floatValue)
                    }
                    else
                    {
                        self.layer.borderWidth = 1.0
                    }
                    if let borderColorString = styleBorder["color"] as? String
                    {
                        self.layer.borderColor = UIColor.colorWithHexString(borderColorString)?.cgColor
                    }
                    if (self.isEnabled == false)
                    {
                        if let disabledBorderColorString = styleBorder["disabledBorderColor"] as? String
                        {
                            if let disabledBorderColorAlphaString = styleBorder["disabledBorderColorAlpha"] as? NSString
                            {
                                self.layer.borderColor = UIColor.colorWithHexString(disabledBorderColorString, alpha:disabledBorderColorAlphaString.floatValue)?.cgColor
                            }
                            else
                            {
                                self.layer.borderColor = UIColor.colorWithHexString(disabledBorderColorString)?.cgColor
                            }
                        }
                    }
                }
                
                if let normalColorString = style["normalColor"] as? String
                {
                    if (normalColorString.isEmpty == false)
                    {
                        if let normalColor = UIColor.colorWithHexString(normalColorString)
                        {
                            self.setBackgroundColor(normalColor, forState: UIControlState())
                        }
                    }
                    else
                    {
                        self.setBackgroundColor(UIColor.clear, forState: UIControlState())
                    }
                }
                if let disabledColorString = style["disabledColor"] as? String
                {
                    if let disabledColor = UIColor.colorWithHexString(disabledColorString)
                    {
                        self.setBackgroundColor(disabledColor, forState: .disabled)
                    }
                }
                if let selectedColorString = style["selectedColor"] as? String
                {
                    if (selectedColorString.isEmpty == false)
                    {
                        if let selectedColor = UIColor.colorWithHexString(selectedColorString)
                        {
                            self.setBackgroundColor(selectedColor, forState: .selected)
                        }
                    }
                    else
                    {
                        self.setBackgroundColor(UIColor.clear, forState: UIControlState())
                    }
                }
                if let highlightedColorString = style["highlightedColor"] as? String
                {
                    if (highlightedColorString.isEmpty == false)
                    {
                        if let highlightedColor = UIColor.colorWithHexString(highlightedColorString)
                        {
                            self.setBackgroundColor(highlightedColor, forState: .highlighted)
                        }
                    }
                    else
                    {
                        self.setBackgroundColor(UIColor.clear, forState:.highlighted)
                    }
                }
                if let textColorString = style["textColor"] as? String
                {
                    if let textColor = UIColor.colorWithHexString(textColorString)
                    {
                        self.setTitleColor(textColor, for: UIControlState())
                    }
                }
                if let disabledTextColorString = style["disabledTextColor"] as? String
                {
                    if let disabledTextColorAlphaString = style["disabledTextColorAlpha"] as? NSString
                    {
                        if let disabledTextColor = UIColor.colorWithHexString(disabledTextColorString, alpha:disabledTextColorAlphaString.floatValue)
                        {
                            self.setTitleColor(disabledTextColor, for: UIControlState.disabled)
                        }
                    }
                    else
                    {
                        if let disabledTextColor = UIColor.colorWithHexString(disabledTextColorString)
                        {
                            self.setTitleColor(disabledTextColor, for: UIControlState.disabled)
                        }
                    }
                }
                if let selectedTextColorString = style["selectedTextColor"] as? String
                {
                    if let selectedTextColor = UIColor.colorWithHexString(selectedTextColorString)
                    {
                        self.setTitleColor(selectedTextColor, for: UIControlState.selected)
                    }
                }
                if let fontName = style["fontName"] as? String
                {
                    if let fontSize = style["fontSize"] as? NSString
                    {
                        let font = UIFont(name: fontName, size: CGFloat(fontSize.floatValue))
                        self.titleLabel?.font = font
                    }
                }
            }
        }
    }
    
}
