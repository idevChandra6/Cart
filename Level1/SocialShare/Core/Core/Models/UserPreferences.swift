//
//  UserPreferences.swift
//  OneMarket
//
//  Created by Jain, Vijay on 6/2/15.
//  Copyright (c) 2015 VISA. All rights reserved.
//

import UIKit



open class UserPreferences: NSObject
{
    public static let sharedInstance = UserPreferences()

    static let environmentKey = "Environment"
    let IsFirstAppSession = "IsFirstAppSession"
    
    
    open var isFirstAppSession: Bool
    {
        get
        {
            return UserDefaults.standard.bool(forKey: IsFirstAppSession)
        }
        set
        {
            UserDefaults.standard.set(newValue, forKey: IsFirstAppSession)
            UserDefaults.standard.synchronize()
        }
    }
    
    open var environment: String?
    {
        get
        {
            return  UserDefaults.standard.object(forKey: UserPreferences.environmentKey) as? String
        }
        set
        {
            UserDefaults.standard.set(newValue, forKey: UserPreferences.environmentKey)
            UserDefaults.standard.synchronize()
        }
    }

    
    open func incrementSessionCount()
    {
        if let sessionCount = self.sessionCount
        {
            self.sessionCount = sessionCount+1
        }
    }
    
    open  var sessionCount: Int?
    {
        get
        {
            if let sessionCount = UserDefaults.standard.object(forKey: "SessionCount") as! NSNumber?
            {
                return sessionCount.intValue
            }
            return 0
        }
        set
        {
            if let newSessionCount = newValue
            {
                UserDefaults.standard.set(NSNumber(value:newSessionCount), forKey:"SessionCount")
                UserDefaults.standard.synchronize()
            }
        }
    }

    open func load(forKey key:String) -> Any?
    {
        let value = UserDefaults.standard.object(forKey: key)
        return value
    }

    open func load<T>(forKey key:String) -> [T]?
    {
        var collections:[T]? = nil
        if let data =  UserDefaults.standard.object(forKey: key) as? Data
        {
            collections = NSKeyedUnarchiver.unarchiveObject(with: data) as? [T]
        }
        return collections
    }

    open func save<T>(_ array:[T], forKey:String)
    {
        let data = NSKeyedArchiver.archivedData(withRootObject: array)
        UserDefaults.standard.set(data, forKey: forKey)
        UserDefaults.standard.synchronize()
    }
    
    open func remove(forKey key:String)
    {
        //NSUserDefaults.standardUserDefaults().removeObjectForKey(key)
        UserDefaults.standard.set(nil, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
}
