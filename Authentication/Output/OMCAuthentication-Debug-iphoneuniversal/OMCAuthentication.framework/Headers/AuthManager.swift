//
//  AuthManager.swift
//  OneMarket
//
//  Created by Jain, Vijay on 6/23/15.
//  Copyright (c) 2015 VISA. All rights reserved.
//

import UIKit
import OMCCore

open class AuthManager: NSObject {
   
    public static let sharedInstance = AuthManager()
   
    var authenticatedUser: User?
    var authService:AuthService?
    public var isUserTouchAuthenticated:Bool
    public var areUsersEyesVerified:Bool
    
    private override init()
    {
        self.isUserTouchAuthenticated = false
        self.areUsersEyesVerified = false
        super.init()
    }
    
    public func isUserAuthenticated() -> Bool
    {
        if self.isUserSignedIn() == true
        {
            if (self.isUserTouchAuthenticated == true)
            {
                return true
            }
        }
        return false
    }
    
    
    public func isUserSignedIn() -> Bool
    {
        if AuthManager.sharedInstance.signedInUser() == nil
        {
            return false
        }
        else
        {
            return true
        }
    }

    public func signedInUser() -> User?
    {
        var returnUser: User? = nil
        if let user = AuthManager.sharedInstance.authenticatedUser
        {
            returnUser = user
        }
        else
        {
            if let user = User.retrieveLastUser()
            {
                AuthManager.sharedInstance.authenticatedUser = user
                returnUser = user
            }
        }
        return returnUser
    }
    
    public func signout(_ userId : String, errorHandler:@escaping (_ error:Error?) -> (), completionHandler:@escaping ()->())
    {
        if (self.authService == nil)
        {
            self.authService = AuthService()
        }
        self.authService?.singOutUser(userId, errorHandler: errorHandler)
        {
            self.signoutLocally(userId)
            UserPreferences.sharedInstance.isEyeVerificationEnrollmentRequested = false
            EyeAuthManager.sharedInstance.removeEnrolledUser()
            completionHandler()
        }
    }
    
    public func signoutLocally(_ userId : String)
    {
        self.authenticatedUser = AuthManager.sharedInstance.authenticatedUser
        User.removeLastUser()
        AuthManager.sharedInstance.authenticatedUser = nil
    }
    
    public func signInWithUserId(_ userId:String, password:String, errorHandler:@escaping (_ error:Error?) -> (), completionHandler:@escaping ()->())
    {
        if (self.authService == nil)
        {
            self.authService = AuthService()
        }
        self.authService?.authenticateUser(userId, password:password, errorHandler:errorHandler)
        {
            self.authenticatedUser = self.authService?.user
            self.authenticatedUser?.Save()
            self.isUserTouchAuthenticated = true
            completionHandler()
        }
        
    }

    public func saveSignInUser(_ user:User, completionHandler:()->())
    {
        self.authenticatedUser = user
        self.authenticatedUser?.Save()
        completionHandler()
        
    }

}
