//
//  AuthenticationAdapter.swift
//  Authentication
//
//  Created by Jain, Vijay on 9/19/16.
//  Copyright © 2016 Visa Inc. All rights reserved.
//

import UIKit
import Core

open class AuthenticationAdapter: NSObject
{
    let authUIDelegate:AuthUIProtocol
    
    public weak var signInAdapterDelegate:SignInAdapterProtocol?
    public weak var touchIdAdapterDelegate:TouchIdAdapterProtocol?
    public weak var eyePrintAdapterDelegate:EyePrintEnrollmentAdpaterProtocol?
    public weak var eyeVerificationAdapterDelegate:EyeVerificationAdpaterProtocol?
    public weak var signOutAdapterDelegate:SignOutAdapterProtocol?
    
    public init(authUIDelegate:AuthUIProtocol)
    {
        self.authUIDelegate = authUIDelegate
    }
    
    public func authenticateIfUnauthenticated()
    {
        if let signInAdapterDelegate = self.signInAdapterDelegate
        {
            if (AuthManager.sharedInstance.isUserSignedIn() == false)
            {
                DispatchQueue.main.async {
                    self.authUIDelegate.displaySignInViewController(delegate:signInAdapterDelegate)
                }
            }
        }
        if let touchIdAdapterDelegate = self.touchIdAdapterDelegate
        {
            if (AuthManager.sharedInstance.isUserTouchAuthenticated == false)
            {
                DispatchQueue.main.async {
                    self.authUIDelegate.displayTouchIdViewController(delegate:touchIdAdapterDelegate)
                }
            }
        }
        else if let eyeVerificationAdapterDelegate = self.eyeVerificationAdapterDelegate
        {
            if (AuthManager.sharedInstance.areUsersEyesVerified == false)
            {
                DispatchQueue.main.async {
                    self.authUIDelegate.displayEyeVeriifyViewController(delegate: eyeVerificationAdapterDelegate)
                }
            }
        }
    }
    
    public func signout(errorHandler:@escaping (Error?) -> (), completionHandler:@escaping ()->())
    {
        if let user = AuthManager.sharedInstance.authenticatedUser
        {
            AuthManager.sharedInstance.signoutLocally(user.uid!)
            AnalyticsAgent.sharedInstance.trackLogout(authenticatedUser:user)
            
            if ((UserPreferences.sharedInstance.isEyeVerificationEnrollmentRequested == true) || (EyeAuthManager.sharedInstance.isUserEnrolledInEyeVerification() == true))
            {
                UserPreferences.sharedInstance.isEyeVerificationEnrollmentRequested = false
                EyeAuthManager.sharedInstance.removeEnrolledUser()
            }
            
            if let signOutAdapterDelegate = self.signOutAdapterDelegate
            {
                if let uid = user.uid
                {
                    signOutAdapterDelegate.userWillSignOut(uid, errorHandler: errorHandler, completion:
                    {
                        completionHandler()
                        if let signInAdapterDelegate = self.signInAdapterDelegate
                        {
                            self.authUIDelegate.displaySignInViewController(delegate: signInAdapterDelegate)
                        }
                    })
                }
            }
            else
            {
                
            }
        }
        
    }
        
}
