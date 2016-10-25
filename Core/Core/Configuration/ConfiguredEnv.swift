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
    public static let sharedInstance = ConfiguredEnv()
    public let environmentKey = "Environment"
    
    public var baseurlString: String = ""
    public var apiTokenString: String = ""
    public var configEnvDictionary: NSDictionary?
    public var testURL = ""
    
    private override init()
    {
        if let plistPath = Bundle.main.path(forResource: "ConfigEnvironment", ofType: "plist")
        {
            self.configEnvDictionary = NSDictionary(contentsOfFile: plistPath)
        }
    }
    
    public var environment : String
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
    
    public var baseUrl:String
    {
        get
        {
//            var serverEnv = "dev"
//            switch (ConfiguredEnv.sharedInstance.environment)
//            {
//            case "Production":
//                return "https://now-api.visa.com/"
//            case "ProductionTest":
//                serverEnv = "production"
//            case "Staging":
//                serverEnv = "staging"
//            default:
//                serverEnv = "dev"
//            }
//            //return "https://innovation-platform-" + serverEnv + ".herokuapp.com/"
            return ConfiguredEnv.sharedInstance.baseurlString
        }
        set
        {
            ConfiguredEnv.sharedInstance.baseurlString = newValue
        }
    }
    
    public var apiToken:String
        {
        get
        {
            return ConfiguredEnv.sharedInstance.apiTokenString
        }
        set
        {
            ConfiguredEnv.sharedInstance.apiTokenString = newValue
        }
    }
    
    public func getbaseURL() -> String
    {
        return ConfiguredEnv.sharedInstance.baseUrl
    }
    
    
    public var baseApiUrl:String
    {
        let baseurlString = self.getbaseURL()
        return baseurlString + "/api/"
    }
    
    public var baseVerApiUrl:String
    {
        let baseurlString = self.getbaseURL()
        return baseurlString + "/api/v1/"
    }
    
    public var baseVersionedApiUrl:String
    {
        let baseurlString = self.getbaseURL()
        return baseurlString + "/api/v1/"
    }
    
    
    public class func stringForKey(_ key: String, environment: String = ConfiguredEnv.sharedInstance.environment) -> String?
    {
        let serviceDictionaryForEnv = ConfiguredEnv.sharedInstance.configEnvDictionary?.object(forKey: environment) as? NSDictionary
        return serviceDictionaryForEnv?.object(forKey: key) as? String
    }
    
    public class func arrayForKey(_ key: String, environment: String = ConfiguredEnv.sharedInstance.environment) -> NSArray?
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
                return displayServerError.lowercased() == "yes" ?true :false
            }
            else
            {
                // Log.dlog("Display Server Error: No")
                return false
            }
        }
    }
    
    public class var isMockServiceEnabled : Bool
        {
        get
        {
            if let mockServiceEnabled = ConfiguredEnv.stringForKey("MockServiceEnabled")
            {
                return mockServiceEnabled.lowercased() == "yes" ?true:false
            }
            else
            {
                return false
            }
        }
    }
    
    
}
