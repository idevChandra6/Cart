//
//  EyeAuthEnrollmentIntroViewController.swift
//  Authentication
//
//  Created by Jain, Vijay on 4/6/16.
//  Copyright © 2016 Visa Inc. All rights reserved.
//

import UIKit
import Core

class EyeAuthEnrollmentIntro1ViewController: BaseViewController
{
    weak var eyePrintEnrollmentAdpaterDelegate:EyePrintEnrollmentAdpaterProtocol?
    override open var analyticsScreenName:String
    {
        get
        {
            return "Eye Enrollment 1"
        }
    }
    
    @IBAction func skipButtonTouched()
    {
        UserPreferences.sharedInstance.isEyeVerificationEnrollmentRequested = true
        self.dismiss(animated: true)
        {
            self.eyePrintEnrollmentAdpaterDelegate?.eyePrintEnrollmentCancelled()
        }
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        //self.renderBackgroundViewColor(self.view)
    }
    
}
