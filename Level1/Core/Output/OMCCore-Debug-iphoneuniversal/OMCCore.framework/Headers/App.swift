//
//  App.swift
//  OneMarket
//
//  Created by Vijay Jain on 5/27/15.
//  Copyright (c) 2015 VISA. All rights reserved.
//

import UIKit

open class App: NSObject {
 
    public class var appName : String?
    {
        get
        {
            if let infoDictionary = Bundle.main.infoDictionary as NSDictionary?
            {
                return  infoDictionary.object(forKey: "CFBundleExecutable") as? String
            }
            return nil
        }
    }
    
    public class var appVersion : String?
    {
        get
        {
            if let infoDictionary = Bundle.main.infoDictionary as NSDictionary?
            {
                return  infoDictionary.object(forKey: "CFBundleShortVersionString") as? String
            }
            return nil
        }
    }
    
    public class var appBuildNumber: String?
    {
        get
        {
            if let infoDictionary = Bundle.main.infoDictionary as NSDictionary?
            {
                return infoDictionary.object(forKey: "CFBundleVersion") as? String
            }
            return nil
        }
    }
    
    public class var appVersionAndBuildNumber: String?
    {
        get
        {
            if let version = App.appVersion
            {
                if let build = App.appBuildNumber
                {
                    return "\(version).\(build)"
                }
            }
            return nil
        }
    }
    
    public class func generateNewSessionId() -> String
    {
        return UUID().uuidString
        
    }
    
    public class var culture: NSDictionary?
    {
        get
            {
                let cultureDictionary = NSMutableDictionary()
                cultureDictionary.setValue("en-US", forKey: "locale")
                let currentLocale = NSLocale.current.identifier
                let localeStrings = currentLocale.components(separatedBy: "_")
                if localeStrings[0] == "es"
                {
                    cultureDictionary.setValue("es-ES", forKey: "locale")
                }
                else if localeStrings[0] == "pt"
                {
                    cultureDictionary.setValue("pt-BR", forKey: "locale")
                }
                return cultureDictionary
        }
        
    }
    
    public class var dateLocaleIdentifier: NSDictionary?
        {
        get
        {
            let cultureDictionary = NSMutableDictionary()
            cultureDictionary.setValue("en_US", forKey: "locale")
            let currentLocale = NSLocale.current.identifier
            let localeStrings = currentLocale.components(separatedBy: "_")
            if localeStrings[0] == "es"
            {
                cultureDictionary.setValue("es_ES", forKey: "locale")
            }
            else if localeStrings[0] == "pt"
            {
                cultureDictionary.setValue("pt_BR", forKey: "locale")
            }
            return cultureDictionary
        }
        
    }

}
