//
//  UITextFieldStyleExtension.swift
//  OneMarket
//
//  Created by Jain, Vijay on 6/12/15.
//  Copyright (c) 2015 VISA. All rights reserved.
//

import UIKit

extension UITextField
{
    override func setStyle(_ styleName:String)
    {
        if let styleDictionary = ConfiguredStyle.sharedInstance.styles
        {
            if let style = styleDictionary[styleName] as? NSDictionary
            {
                var placeholderAttributes = [String:AnyObject]()
                if let colorString = style["placeholderTextColor"] as? String
                {
                    var color:UIColor?
                    if let colorAlphaString = style["placeholderTextColorAlpha"] as? NSString
                    {
                        color = UIColor.colorWithHexString(colorString, alpha:colorAlphaString.floatValue)
                    }
                    else
                    {
                        color = UIColor.colorWithHexString(colorString)
                    }
                    placeholderAttributes[NSForegroundColorAttributeName] = color
                }
                if let placeholderTextFont = style["placeholderTextFontName"] as? String
                {
                    if let placeholderTextFontSize = style["placeholderTextFontSize"] as? NSString
                    {
                        let font = UIFont(name: placeholderTextFont, size: CGFloat(placeholderTextFontSize.floatValue))
                        placeholderAttributes[NSFontAttributeName] = font
                    }
                }
                if let placeholder = self.placeholder
                {
                    self.attributedPlaceholder = NSAttributedString(string: placeholder, attributes:placeholderAttributes)
                }
                var textAttributes = [String:AnyObject]()
                if let colorString = style["textColor"] as? String
                {
                    var color:UIColor?
                    if let colorAlphaString = style["textColor"] as? NSString
                    {
                        color = UIColor.colorWithHexString(colorString, alpha:colorAlphaString.floatValue)
                    }
                    else
                    {
                        color = UIColor.colorWithHexString(colorString)
                    }
                    UITextField.appearance().tintColor = color
                }
                if let textFont = style["textFont"] as? String
                {
                    if let textFontSize = style["textFontSize"] as? NSString
                    {
                        let font = UIFont(name: textFont, size: CGFloat(textFontSize.floatValue))
                        textAttributes[NSFontAttributeName] = font
                    }
                }
                if let text = self.text
                {
                    self.attributedText = NSAttributedString(string: text, attributes:textAttributes)
                }
            }
        }
    }
    
}
