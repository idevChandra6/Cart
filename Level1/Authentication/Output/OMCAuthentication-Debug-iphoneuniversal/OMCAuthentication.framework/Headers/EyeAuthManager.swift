//
//  EyeAuthManager.swift
//  Authentication
//
//  Created by Jain, Vijay on 4/6/16.
//  Copyright © 2016 Visa Inc. All rights reserved.
//

import UIKit
import OMCCore
class EyeAuthManager: NSObject
{
    static let sharedInstance = EyeAuthManager()

    let eyeVerifyLoader = EyeVerifyLoader()
    let EyeVerifyLicense = "1S99MHYR9CXSWNLB"
    weak var eyeAuthDelegate:EyeAuthProtocol?
    fileprivate var isUserEyeVerified:Bool = false
    var userCancelled:Bool = false
    
    func setEVAuthSessionDelegate(_ evAuthSessionDelegate:EVAuthSessionDelegate)
    {
        EyeVerifyLoader.getEyeVerifyInstance().setEVAuthSessionDelegate(evAuthSessionDelegate)
    }
    
    var isUserVerified:Bool
    {
        get
        {
            var returnValue = true
            if (Device.isSimulator() == false)
            {
                if (EyeAuthManager.sharedInstance.isUserEnrolledInEyeVerification() == true)
                {
                    returnValue = EyeAuthManager.sharedInstance.isUserEyeVerified
                }
            }
            return returnValue
        }
        set
        {
            EyeAuthManager.sharedInstance.isUserEyeVerified = newValue
        }
    }
    
    private override init()
    {
        super.init()
        eyeVerifyLoader.loadEyeVerify(withLicense: EyeVerifyLicense)
    }
    
    func continueAuthentication()
    {
        EyeVerifyLoader.getEyeVerifyInstance().continueAuth()
    }
    
    func setCaptureView(_ view:UIView)
    {
        EyeVerifyLoader.getEyeVerifyInstance().setCapture(view)
    }
    
    func isUserEnrolledInEyeVerification() -> Bool
    {
        if let userId = AuthManager.sharedInstance.signedInUser()?.uid
        {
            return EyeVerifyLoader.getEyeVerifyInstance().isUserEnrolled(userId)
        }
        else
        {
            return false
        }
    }
    
    func removeEnrolledUser()
    {
        if let userId = AuthManager.sharedInstance.authenticatedUser?.uid
        {
            EyeVerifyLoader.getEyeVerifyInstance().removeUser(userId)
        }
    }


    func enrollUserForEyeVerification()
    {
        self.isUserEyeVerified = false
        if let user = AuthManager.sharedInstance.signedInUser()
        {
            if let userId = user.uid
            {
                EyeVerifyLoader.getEyeVerifyInstance().userName = userId
                if let accessToken = user.accessToken
                {
                    let accessTokenData = accessToken.data(using: String.Encoding.utf8)
                    EyeVerifyLoader.getEyeVerifyInstance().enrollUser(userId, userKey:accessTokenData)
                    {
                        (result: EVEnrollmentResult, userKey:Data?, abort_reason: EVAbortReason) -> Void in
                        
                        switch(result)
                        {
                            case EVEnrollmentResultSuccess:
                            self.eyeAuthDelegate?.enrollmentSucceded()
                            case EVEnrollmentResultAborted:
                            self.eyeAuthDelegate?.enrollmentAborted(abort_reason)
                            default:
                            self.eyeAuthDelegate?.enrollmentFailed(result)
                        }
                    }
                }
            }
        }
    }
    
    func verifyUserForEyeVerification()
    {
        if let user = AuthManager.sharedInstance.signedInUser()
        {
            if let userId = user.uid
            {
                EyeVerifyLoader.getEyeVerifyInstance().userName = userId
                EyeVerifyLoader.getEyeVerifyInstance().verifyUser(userId)
                {
                    (result: EVVerifyResult, userKey:Data?, abort_reason: EVAbortReason) -> Void in
                    switch(result)
                    {
                    case EVVerifyResultMatch, EVVerifyResultMatchWithEnroll:
                        self.isUserEyeVerified = true
                        self.eyeAuthDelegate?.verificationSucceded()
                    case EVVerifyResultAborted:
                        self.eyeAuthDelegate?.verificationAborted(abort_reason)
                    default:
                        self.eyeAuthDelegate?.verificationFailed(result)
                    }
                }
            }
        }
    }

}
