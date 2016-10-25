//
//  AuthUIProtocolExtension.swift
//  Authentication
//
//  Created by Jain, Vijay on 9/21/16.
//  Copyright © 2016 Visa Inc. All rights reserved.
//

import UIKit
import LocalAuthentication

public extension AuthUIProtocol where Self:UIViewController
{
    func displaySignInViewController(delegate:SignInAdapterProtocol)
    {
        let frameworkBundle = Bundle(identifier: "com.visa.onemarket.Authentication")
        let signInStoryboard = UIStoryboard(name: "Authentication", bundle: frameworkBundle)
        if let signInNavigationController = signInStoryboard.instantiateViewController(withIdentifier: "SignInNavigationController") as? UINavigationController
        {
            if let signInViewController = signInNavigationController.viewControllers[0] as? SignInViewController
            {
                signInViewController.signInAdapterDelegate = delegate
                self.present(signInNavigationController, animated: true, completion: nil)
            }
        }
    }
    
    func displayTouchIdViewController(delegate:TouchIdAdapterProtocol)
    {
        let context = LAContext()
        var error:NSError?
        if (context.canEvaluatePolicy(LAPolicy.deviceOwnerAuthentication, error: &error) == true)
        {
            let frameworkBundle = Bundle(identifier: "com.visa.onemarket.Authentication")
            let signInStoryboard = UIStoryboard(name: "Authentication", bundle: frameworkBundle)
            if let touchIDNavigationController = signInStoryboard.instantiateViewController(withIdentifier: "TouchIDNavigationController") as? UINavigationController
            {
                //self.touchIDNavigationController = touchIDNavigationController
                if let touchIdViewController = touchIDNavigationController.viewControllers[0] as? TouchIDViewController
                {
                    touchIdViewController.touchIdAdapterDelegate = delegate
                    self.present(touchIDNavigationController, animated: true, completion: nil)
                }
            }
        }
        else
        {
            delegate.userNotEqippedWithTouchId()
        }
    }
    
    func displayEyeVeriifyViewController(delegate:EyeVerificationAdpaterProtocol)
    {
        let frameworkBundle = Bundle(identifier: "com.visa.onemarket.Authentication")
        let authenticateStoryboard = UIStoryboard(name: "Authentication", bundle: frameworkBundle)
        if let aNavigationController = authenticateStoryboard.instantiateViewController(withIdentifier: "EyeAuthVerifyNavigationController") as? UINavigationController
        {
            if let viewController = aNavigationController.childViewControllers[0] as? EyeAuthViewController
            {
                viewController.eyeVerificationAdpaterDelegate = delegate
                self.present(aNavigationController, animated: true, completion: nil)
            }
        }
    }
    
}
