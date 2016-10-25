//
//  EyeAuthEnrollmentIntro2ViewController.swift
//  Authentication
//
//  Created by Jain, Vijay on 4/6/16.
//  Copyright © 2016 Visa Inc. All rights reserved.
//

import UIKit
import OMCCore

class EyeAuthEnrollmentIntro2ViewController: BaseViewController, EyeAuthProtocol
{
    @IBOutlet weak var pressStartUILabel: UILabel!
    weak var eyePrintEnrollmentAdpaterProtocol:EyePrintEnrollmentAdpaterProtocol?
    override var analyticsScreenName: String
    {
        get
        {
            return "Eye Enrollment 2"
        }
    }
    
    func lineBreak() {
        let firstLine = NSMutableAttributedString(string: NSLocalizedString("Instructions\n", comment: ""))
        let smallerFontSize = [NSFontAttributeName : UIFont(name: "MyriadPro-Semibold", size: 15)!]
        let secondLine = NSMutableAttributedString(string: NSLocalizedString("Instructions:", comment: ""), attributes: smallerFontSize)
        firstLine.append(secondLine)
        pressStartUILabel.attributedText = firstLine
    }
    
    @IBAction func skipButtonTouched()
    {
        UserPreferences.sharedInstance.isEyeVerificationEnrollmentRequested = true
        self.dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        super.prepare(for: segue, sender: sender)
        if (segue.identifier == "SegueToEnrollment")
        {
            if let navigationController = segue.destination as? UINavigationController
            {
                if let viewController = navigationController.viewControllers[0] as? EyeAuthViewController
                {
                    viewController.eyeAuthCancelDelegate = self
                    viewController.mode = EyeAuthViewController.Mode.enrollment
                }
            }
        }
    }
    
    func enrollmentCancelled()
    {
        self.dismiss(animated: true, completion:
        {
            self.eyePrintEnrollmentAdpaterProtocol?.eyePrintEnrollmentCancelled()
        })
//        let nowStoryboard = UIStoryboard(name: "Now", bundle: nil)
//        let destinationController = nowStoryboard.instantiateViewController(withIdentifier: "NowHomeViewController") as! NowHomeViewController
//        
//        if let delegate = UIApplication.shared.delegate as? AppDelegate
//        {
//            delegate.displayViewController(nowStoryboard, destinationViewController: destinationController)
//        }
        
    }
    
    func enrollmentSucceded()
    {
        
    }
    func enrollmentFailed(_ result:EVEnrollmentResult)
    {
        
    }
    func enrollmentAborted(_ abortReason: EVAbortReason)
    {
        
    }
    
    func verificationSucceded()
    {
        
    }
    func verificationFailed(_ result:EVVerifyResult)
    {
        
    }
    func verificationAborted(_ abortReason: EVAbortReason)
    {
        
    }

    func verificationCancelled()
    {
        
    }
}
