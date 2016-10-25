//
//  Device.swift
//  OneMarket
//
//  Created by Vijay Jain on 5/27/15.
//  Copyright (c) 2015 VISA. All rights reserved.
//

import UIKit

open class Device: NSObject {
    
    public class func isSimulator() -> Bool
    {
        var returnValue = false
        
        let platform = Device.hardwarePlatform()
        if platform == "x86_64"
        {
            returnValue = true
        }
        return returnValue
    }
    public class func isiPhone6Or6S() -> Bool
    {
        var returnValue = false
    
        let platform = Device.hardwarePlatform()
        if platform == "x86_64"
        {
            var screenWidth:CGFloat = 0.0;
            let interfaceOrientation = UIApplication.shared.statusBarOrientation
            if (UIInterfaceOrientationIsPortrait(interfaceOrientation))
            {
                screenWidth = UIScreen.main.bounds.size.width
            }
            else
            {
                screenWidth = UIScreen.main.bounds.size.height
            }
        
            if (screenWidth >= 375)
            {
                returnValue = true
            }
        }
        else if (platform == "iPhone7,2") || (platform == "iPhone8,1")
        {
            returnValue = true
        }
        return returnValue;
    }

    public class func isiPhone6PlusOr6SPlus() -> Bool
    {
        var returnValue = false
        
        let platform = Device.hardwarePlatform()
        if platform == "x86_64"
        {
            var screenWidth:CGFloat = 0.0;
            let interfaceOrientation = UIApplication.shared.statusBarOrientation
            if (UIInterfaceOrientationIsPortrait(interfaceOrientation))
            {
                screenWidth = UIScreen.main.bounds.size.width
            }
            else
            {
                screenWidth = UIScreen.main.bounds.size.height
            }
            
            if (screenWidth >= 414)
            {
                returnValue = true
            }
        }
        else if (platform == "iPhone8,2") || (platform == "iPhone7,1")
        {
            returnValue = true
        }
        return returnValue;
    }

    public class func iOSVersion() ->String
    {
        return UIDevice.current.systemVersion
    }
    
    public class func hardwarePlatform() -> String
    {
        if let key = "hw.machine".cString(using: String.Encoding.utf8)
        {
            var size : Int = 0
            sysctlbyname(key, nil, &size, nil, 0)
            var machine = [CChar](repeating: 0, count: Int(size))
            sysctlbyname(key, &machine, &size, nil, 0)
            return String(cString: machine)
        }
        return ""
    }
    
    public class func isiPhone5() -> Bool
    {
        let device = Device.hardwarePlatform()
        if device.hasPrefix("iPhone5") == true
        {
            return true
        }
        return false
    }
    
}
