//
//  ConfiguredEnv.swift
//  Core
//
//  Created by Jain, Vijay on 9/15/16.
//  Copyright © 2016 Visa Inc. All rights reserved.
//

import UIKit

open class ConfiguredEnv: NSObject
{

    static let sharedInstance = ConfiguredEnv()
    static let environmentKey = "Environment"

    var configEnvDictionary: NSDictionary?
    
    private override init()
    {
        if let plistPath = Bundle.main.path(forResource: "ConfigEnvironment", ofType: "plist")
        {
            self.configEnvDictionary = NSDictionary(contentsOfFile: plistPath)
            
        }
    }
    
    public class var environment : String
        {
        get
        {
            if let preferredEnvironment = UserDefaults.standard.object(forKey: environmentKey) as? String
            {
                return preferredEnvironment;
            }
            else
            {
                if let anEnvironment = ConfiguredEnv.sharedInstance.configEnvDictionary?.object(forKey: environmentKey) as? String
                {
                    return anEnvironment
                }
                else
                {
                    return "Dev"
                }
            }
        }
        set
        {
            UserDefaults.standard.set(newValue, forKey: environmentKey)
            UserDefaults.standard.synchronize()
        }
        
    }
    
    public class var baseUrl:String
    {
        get
        {
            var serverEnv = "dev"
            switch (environment)
            {
            case "Production":
                return "https://now-api.visa.com/"
            case "ProductionTest":
                serverEnv = "production"
            case "Staging":
                serverEnv = "staging"
            default:
                serverEnv = "dev"
            }
            return "https://concierge-api-\(serverEnv).herokuapp.com/"
        }
    }
    
    public class var baseApiUrl:String
    {
        return "\(baseUrl)api/"
    }
    
    public class var baseVerApiUrl:String
    {
        return "\(baseApiUrl)v1/"
    }
    
    public class var baseVersionedApiUrl:String
    {
        return "\(baseApiUrl)v1/"
    }
    
    
    public class func stringForKey(_ key: String, environment: String = ConfiguredEnv.environment) -> String?
    {
        let serviceDictionaryForEnv = ConfiguredEnv.sharedInstance.configEnvDictionary?.object(forKey: environment) as? NSDictionary
        return serviceDictionaryForEnv?.object(forKey: key) as? String
    }
    
    public class func arrayForKey(_ key: String, environment: String = ConfiguredEnv.environment) -> NSArray?
    {
        let serviceDictionaryForEnv = ConfiguredEnv.sharedInstance.configEnvDictionary?.object(forKey: environment) as? NSDictionary
        return serviceDictionaryForEnv?.object(forKey: key) as? NSArray
    }
    
    public class func stringForKeyForAnyEnv(_ key: String) -> String?
    {
        var returnValue: String? = nil
        if let dictionary = ConfiguredEnv.sharedInstance.configEnvDictionary
        {
            returnValue = dictionary.value(forKey: key) as? String
        }
        return returnValue
    }
    
    public class func googleAnalyticsAccount() -> String?
    {
        if let aGoogleAnalyticsAccount = ConfiguredEnv.stringForKey("GoogleAnalyticsAccount")
        {
            return aGoogleAnalyticsAccount
        }
        return nil
    }

    public class var canDisplayParsigError : Bool
        {
        get
        {
            if let displayParseError = ConfiguredEnv.stringForKey("DisplayParseError")
            {
                // Log.dlog("Display Parse Error: \(displayParseError)")
                return displayParseError.lowercased() == "yes" ?true :false
            }
            else
            {
                // Log.dlog("Display Parse Error: No")
                return false
            }
        }
    }
    
    public class var canDisplayServerError : Bool
        {
        get
        {
            if let displayServerError = ConfiguredEnv.stringForKey("DisplayServerError")
            {
                // Log.dlog("Display Server Error: \(displayServerError)")
                return displayServerError.lowercased() == "yes" ?true :false
            }
            else
            {
                // Log.dlog("Display Server Error: No")
                return false
            }
        }
    }


}
