//
//  AnalyticsAgent.swift
//  Core
//
//  Created by Jain, Vijay on 9/14/16.
//  Copyright © 2016 Visa Inc. All rights reserved.
//

import UIKit


open class AnalyticsAgent: NSObject
{
    public static let sharedInstance = AnalyticsAgent()
    
    var gaiTracker: GAITracker?
    var sessionId:String?
    var sessionStartTime: Date?
    var screenViewStartTime: Date?
    //    var getWifiAddress = GetWifiAddress()
    
    
    private override init()
    {
        super.init()
        self.initializeGATracker()
    }
    
    func initializeGATracker()
    {
        GAI.sharedInstance().trackUncaughtExceptions = true
        GAI.sharedInstance().logger.logLevel = GAILogLevel.none
        GAI.sharedInstance().dispatchInterval = 5
        self.gaiTracker = GAI.sharedInstance().tracker(withTrackingId: ConfiguredEnv.googleAnalyticsAccount())
        if let version = App.appVersionAndBuildNumber {
            self.gaiTracker?.set(kGAIAppVersion, value: version)
        }
    }
    
    public func trackSessionStarted()
    {
        self.sessionId = UUID().uuidString
        self.sessionStartTime =  Date()
        let dictionary = GAIDictionaryBuilder.createEvent(withCategory: "Session", action:"Started", label:nil, value:nil).set(self.sessionId! as String, forKey: "SessionId").build() as [NSObject : AnyObject]
        self.gaiTracker?.send(dictionary)
    }
    
    public func trackSessionEnded()
    {
        if let intervalBeweenSessionStartedTimeAnd1970 = self.sessionStartTime?.timeIntervalSince1970
        {
            let duration = NSString(format:"%.2f", Date().timeIntervalSince1970-intervalBeweenSessionStartedTimeAnd1970)
            let dictionary = GAIDictionaryBuilder.createEvent(withCategory: "Session", action:"Ended", label:nil, value:nil).set(self.sessionId! as String, forKey: "SessionId").set(duration as String, forKey: "Duration").build() as [NSObject : AnyObject]
            self.gaiTracker?.send(dictionary)
        }
    }
    public func trackScreenViewStarted (_ screenName: String)
    {
        // Log.dlog("screenName:\(screenName)")
        if (screenName.isEmpty == false)
        {
            self.screenViewStartTime = Date()
            self.gaiTracker?.set(kGAIScreenName, value: screenName)
            let dict = GAIDictionaryBuilder.createScreenView().build() as [NSObject : AnyObject]
            self.gaiTracker?.send(dict)
            
            let dictionary = GAIDictionaryBuilder.createEvent(withCategory: "ScreenView", action:"Began", label:screenName, value:nil).build() as [NSObject : AnyObject]
            self.gaiTracker?.send(dictionary)
        }
    }
    
    public func trackScreenViewEnded(_ screenName: String)
    {
        if (screenName.isEmpty == false)
        {
            if let intervalBeweenSessionStartedTimeAnd1970 = self.screenViewStartTime?.timeIntervalSince1970
            {
                let timeInterval = Date().timeIntervalSince1970-intervalBeweenSessionStartedTimeAnd1970
                
                self.gaiTracker?.set(kGAIScreenName, value: screenName)
                let dict = GAIDictionaryBuilder.createTiming(withCategory: "ScreenView", interval: NSNumber(value: timeInterval * 1000), name: screenName, label: "Ended").build() as [NSObject : AnyObject]
                self.gaiTracker?.send(dict)
                
                let dictionary = GAIDictionaryBuilder.createEvent(withCategory: "ScreenView", action:"Ended", label:screenName, value:nil).build() as [NSObject : AnyObject]
                self.gaiTracker?.send(dictionary)
            }
        }
    }
    
    public func trackButtonTapped(_ screenName:String, buttonName:String)
    {
        if (screenName.isEmpty == false)
        {
            self.gaiTracker?.set(kGAIScreenName, value: screenName)
            let dictionary = GAIDictionaryBuilder.createEvent(withCategory: "Button", action:"Tapped", label:buttonName, value:nil).build() as [NSObject : AnyObject]
            self.gaiTracker?.send(dictionary)
        }
    }
    
    
    public func trackError(_ screenName:String, anError:Error)
    {
        if (screenName.isEmpty == false)
        {
            self.gaiTracker?.set(kGAIScreenName, value: screenName)
            let error = anError as NSError
            let dictionary = GAIDictionaryBuilder.createException(withDescription: error.localizedDescription, withFatal: error.code as NSNumber!).set(screenName as String, forKey: "ScreenName").build() as [NSObject : AnyObject]
            //let dictionary = GAIDictionaryBuilder.createEventWithCategory("Error", action:"Caught", label:nil, value:nil).set(screenName as String, forKey: "ScreenName").set(error.localizedDescription as String, forKey: "Error").build() as [NSObject : AnyObject]
            self.gaiTracker?.send(dictionary)
        }
    }
    
    public func trackUserAction(_ category:String, eventLabel:String, userAction:String)
    {
        let dictionary = GAIDictionaryBuilder.createEvent(withCategory: category, action: userAction, label: eventLabel, value: nil).build() as [NSObject : AnyObject]
        self.gaiTracker?.send(dictionary)
        
        
        
    }
    
    
    public func trackLogin(authenticatedUser user:User)
    {
        if let userpackage = user.packageType
        {
            let dict = GAIDictionaryBuilder.createScreenView().set(userpackage, forKey: GAIFields.customDimension(for: 2)).set("Login", forKey: "Login/Logout").set("1", forKey: GAIFields.customMetric(for: 1)).set(user.uid, forKey: GAIFields.customMetric(for: 2)).build() as [NSObject : AnyObject]
            
            let loginString = "Login" + userpackage
            let dictionary = GAIDictionaryBuilder.createEvent(withCategory: loginString, action: user.uid, label: userpackage, value: nil).build() as [NSObject:AnyObject]
            
            self.gaiTracker?.send(dict)
            self.gaiTracker?.send(dictionary)
        }
    }
    
    
    public func trackLogout(authenticatedUser user:User)
    {
        if let userpackage = user.packageType
        {
            
            let dict = GAIDictionaryBuilder.createScreenView().set(userpackage, forKey: GAIFields.customDimension(for: 2)).set("Logout", forKey: "Login/Logout").set("0", forKey: GAIFields.customMetric(for: 1)).set(user.uid, forKey: GAIFields.customMetric(for: 2)).build() as [NSObject : AnyObject]
            
            let logOutString = "LogOut" + userpackage
            let dictionary = GAIDictionaryBuilder.createEvent(withCategory: logOutString, action: user.uid, label: userpackage, value: nil).build() as [NSObject:AnyObject]
            
            self.gaiTracker?.send(dict)
            self.gaiTracker?.send(dictionary)
        }
    }
    
    
    //    How many clients logged in and logged out
    //    How many consumers logged in and logged out
    //    How many times a specific user logged in and logged out
    //    How many photos taken by all users
    //    How many photos taken by a specific user
    //    How many photos uploaded by all users
    //    How many photos uploaded by a specific user
    
    //    func trackWifiAddress(screenName:String){
    //        if (screenName.isEmpty == false)
    //        {
    //
    //            if let addr = self.getWifiAddress.getWiFiAddress()
    //            {
    //                let dict = GAIDictionaryBuilder.createScreenView().set(addr, forKey: GAIFields.customDimensionForIndex(1)).build() as [NSObject : AnyObject]
    //                // Log.print("Dict: \(dict)")
    //                self.gaiTracker.send(dict)
    //            }
    //            else
    //            {
    //                // Log.print("No WiFi address")
    //            }
    //        }
    //    }

}
