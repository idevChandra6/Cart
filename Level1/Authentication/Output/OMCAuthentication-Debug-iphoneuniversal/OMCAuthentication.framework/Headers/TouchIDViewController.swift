//
//  TouchIDViewController.swift
//  Authentication
//
//  Created by Jain, Vijay on 10/26/15.
//  Copyright © 2015 Visa Inc. All rights reserved.
//

import UIKit
import LocalAuthentication
import OMCCore

class TouchIDViewController: BaseViewController, UIAlertViewDelegate
{
    var putLocaleService = PutLocaleService()

    weak var touchIdAdapterDelegate:TouchIdAdapterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
    }

    override public var analyticsScreenName:String
    {
        return "TouchId"
    }

    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)

        self.authenticateUserWithTouchId()
    }

    func authenticateUserWithTouchId()
    {
        AnalyticsAgent.sharedInstance.trackUserAction("TouchID", eventLabel: "ToucID Screen", userAction: "TouchID Authentication Begins")
        let context = LAContext()
        let reasonString = NSLocalizedString("To access VISA Now, Touch ID authentication is required", comment: "")
        context.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: reasonString,
            reply:
            {
                [weak self]
                (success: Bool, evalPolicyError: Error?) -> Void in
                if let strongSelf = self
                {
                    if (success == true)
                    {
                        strongSelf.putLocaleService.putLocale({ (error) in
                            DispatchQueue.main.async
                            {
                                strongSelf.hideProgressView()
                                strongSelf.userAuthenticatedWithTouchId()
                            }
                            
                            }, completionHandler: {
                                NSLog("PutLocaleService Completed")
                                strongSelf.userAuthenticatedWithTouchId()
                        })
                        
                    }
                    else
                    {
                        DispatchQueue.main.async
                        {
                            AnalyticsAgent.sharedInstance.trackUserAction("TouchID", eventLabel: "ToucID Screen", userAction: "TouchID Authentication Error")
                            if let error  = evalPolicyError
                            {
                                strongSelf.touchIdAdapterDelegate?.touchIdAuthenticationFailed(error: error)
                            }
                        }
                    }
                }
            })
    }
    
    func userAuthenticatedWithTouchId()
    {
        AnalyticsAgent.sharedInstance.trackUserAction("TouchID", eventLabel: "ToucID Screen", userAction: "TouchID Authentication Success")
        AuthManager.sharedInstance.isUserTouchAuthenticated = true
        self.touchIdAdapterDelegate?.downloadContentWithTouchId(errorHandler:
        {
            (error:Error?) in
                DispatchQueue.main.async
                {
                    self.display(error:error)
                }
            },
            completion:
            {
                DispatchQueue.main.async
                {
                    self.dismiss(animated: true, completion: {
                      self.touchIdAdapterDelegate?.touchIdAuthenticationCompleted()
                    })
                }
                
        })
        
//        self.signInDelegate?.downloadContentAfterAuthentication(errorHandler:
//            {
//                (error) in
//                DispatchQueue.main.async
//                {
//                    self.display(error:error)
//                }
//            }, completion: {
//        })
//        ConfigManager.sharedInstance.downloadFunctionalityConfigurations()
//        CacheManager.sharedInstance.cacheAllCrucialData()
//        DispatchQueue.main.async
//        {
//            self.dismiss(animated: true, completion: nil)
//            if SharedResourceManager.sharedInstance.resourceType != ResourceType.none
//            {
//                self.appDelegate.displayResourceType(SharedResourceManager.sharedInstance.resourceType)
//            }
//        }
    }
    
    
//    func displayTouchIdError(_ anError:Error?)
//    {
//        AnalyticsAgent.sharedInstance.trackUserAction("TouchID", eventLabel: "ToucID Screen", userAction: "TouchID Authentication Error")
//        
//        if let evalPolicyError = anError as? NSError
//        {
//            switch evalPolicyError.code
//            {
//            case LAError.Code.authenticationFailed.rawValue:
//                self.signInDelegate?.authenticateWithSignIn()
//                
//            case LAError.Code.passcodeNotSet.rawValue:
//                self.signInDelegate?.authenticateWithSignIn()
//                
//            case LAError.Code.touchIDNotEnrolled.rawValue:
//                self.dismiss(animated: true, completion: nil)
//                let signInStoryboard = UIStoryboard(name: "Authentication", bundle: nil)
//                if let signInNavigationController = signInStoryboard.instantiateViewController(withIdentifier: "SignInNavigationController") as? UINavigationController
//                {
//                    if let _ = signInNavigationController.viewControllers[0] as? SignInViewController
//                    {
//                        self.parent?.present(signInNavigationController, animated: true, completion: nil)
//                    }
//                }
//                
//            case LAError.Code.systemCancel.rawValue:
//                self.signInDelegate?.authenticateWithSignIn()
//                
//            case LAError.Code.userCancel.rawValue:
//                self.signInDelegate?.authenticateWithSignIn()
//                
//            case LAError.Code.userFallback.rawValue:
//                self.signInDelegate?.authenticateWithSignIn()
//                
//            case LAError.Code.touchIDLockout.rawValue:
//                self.signInDelegate?.authenticateWithSignIn()
//                
//            case LAError.Code.touchIDNotAvailable.rawValue:
//                self.dismiss(animated: true, completion: nil)
//                let signInStoryboard = UIStoryboard(name: "Authentication", bundle: nil)
//                if let signInNavigationController = signInStoryboard.instantiateViewController(withIdentifier: "SignInNavigationController") as? UINavigationController
//                {
//                    if let _ = signInNavigationController.viewControllers[0] as? SignInViewController
//                    {
//                        self.parent?.present(signInNavigationController, animated: true, completion: nil)
//                    }
//                }
//                
//                
//            default:break
//            }
//        }
//    }
}
