//
//  SignInViewController.swift
//  Authentication
//
//  Created by Jain, Vijay on 10/22/15.
//  Copyright © 2015 Visa Inc. All rights reserved.
//

import UIKit
import OMCCore

class SignInViewController: BaseViewController, UITextFieldDelegate
{
    @IBOutlet var userIdTextField: UITextField?
    @IBOutlet var passwordTextField: UITextField?
    @IBOutlet var loginButton: UIButton?
    
    var getAuthenticatedUserDetailsService = GetAuthenticatedUserDetailsService()
    var putLocaleService = PutLocaleService()

    weak var signInAdapterDelegate:SignInAdapterProtocol?
    
    @IBOutlet weak var backgroundView: UIView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.title = "Sign In"
        self.navigationController?.isNavigationBarHidden = true
        
        self.userIdTextField?.delegate = self
        self.passwordTextField?.delegate = self
        configTextFieldPlaceholder()
    }
    
    func configTextFieldPlaceholder()
    {
        func textFieldPlaceHolderStr(_ txt: String) -> NSAttributedString
        {
            return NSAttributedString(string: txt, attributes: [NSForegroundColorAttributeName:UIColor.white])
        }
        self.userIdTextField?.attributedPlaceholder = textFieldPlaceHolderStr(NSLocalizedString("User ID", comment: ""))
        self.userIdTextField?.tintColor = UIColor.white
        self.passwordTextField?.attributedPlaceholder = textFieldPlaceHolderStr(NSLocalizedString("Password", comment: ""))
        self.passwordTextField?.tintColor = UIColor.white
    }
    
    @IBAction func signinButtonTouched()
    {
        self.userIdTextField?.resignFirstResponder()
        self.passwordTextField?.resignFirstResponder()
        AnalyticsAgent.sharedInstance.trackUserAction("WebService", eventLabel: "Login", userAction: "User Log in Service start")
        if let userId = self.userIdTextField?.text , userId.characters.count > 0, let password =  self.passwordTextField?.text , password.characters.count > 0
        {
            self.loginButton?.isHidden = true
            self.displayProgressViewWithText("")
            
            AuthManager.sharedInstance.signInWithUserId(userId, password:password,
                errorHandler:
                {
                    (error:Error?) -> () in
                    DispatchQueue.main.async
                        {
                            //AnalyticsAgent.sharedInstance.trackUserAction("WebService", eventLabel: "Login", userAction: "User Log in Service Failed")
                            self.hideProgressView()
                            self.loginButton?.isHidden = false
                            self.display(error:error)
                    }
                },
                completionHandler:
                {
                    () -> () in
                    AnalyticsAgent.sharedInstance.trackUserAction("WebService", eventLabel: "Login", userAction: "User Log in Service Success")
//                    self.putLocaleService.putLocale({ (error) in
//                        DispatchQueue.main.async
//                        {
//                            self.hideProgressView()
//                            self.display(error:error)
//                        }
//
//                        }, completionHandler: {
//                            self.hideProgressView()
//                            NSLog("PutLocaleService Completed")
//                            self.userAuthenticatedWithSignIn()
//                    })
                    DispatchQueue.main.async
                        {
                            self.dismiss(animated: true, completion: nil)
                    }
                    self.signInAdapterDelegate?.signInAuthenticationCompleted()
                    
                }
            )
        }
        else
        {
            let string = NSLocalizedString("Please enter user ID and password to sign in", comment: "")
            let userInfo = [NSLocalizedDescriptionKey: string]
            let error = NSError(domain: "Sign-In Problem", code: 9999, userInfo: userInfo)
            self.display(genericError:error)
        }

    }

    func userAuthenticatedWithSignIn()
    {
        self.getAuthenticatedUserDetailsService.getUserDetails({(error) -> () in
            DispatchQueue.main.async
            {
                self.hideProgressView()
                self.loginButton?.isHidden = false
                self.display(error:error)
            }
            },
           completionHandler:{
            () -> () in
                self.signInAdapterDelegate?.downloadContentWithSignIn(errorHandler:
                    {
                        (error:Error?) in
                        DispatchQueue.main.async
                        {
                            self.display(error:error)
                        }
                    }, completion:
                    {
                        DispatchQueue.main.async
                        {
                            self.dismiss(animated: true, completion: nil)
                        }
                        self.signInAdapterDelegate?.signInAuthenticationCompleted()
                })
                
//                ConfigManager.sharedInstance.downloadFunctionalityConfigurations()
//                CacheManager.sharedInstance.cacheAllCrucialData()
//                self.hideProgressView()
//                if SharedResourceManager.sharedInstance.resourceType != ResourceType.none
//                {
//                    self.appDelegate.displayResourceType(SharedResourceManager.sharedInstance.resourceType)
//                }
//                else
//                {
//                    let storyboard = UIStoryboard(name: "Now", bundle: nil)
//                    let viewController = storyboard.instantiateViewController(withIdentifier: "NowHomeViewController")
//                    if let appDelegate = UIApplication.shared.delegate as? AppDelegate
//                    {
//                        appDelegate.displayViewController(storyboard, destinationViewController: viewController)
//                    }
//                }
        })
    }


}
