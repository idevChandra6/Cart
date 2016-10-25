//
//  EyeAuthEnrollmentViewController.swift
//  Authentication
//
//  Created by Jain, Vijay on 4/6/16.
//  Copyright © 2016 Visa Inc. All rights reserved.
//

import UIKit
import Core

protocol EyeAuthCancelDelegate:class
{
    func verificationCancelled()
}

class EyeAuthViewController: BaseViewController, EVAuthSessionDelegate, EyeAuthProtocol
{
    enum Mode
    {
        case verify
        case enrollment
    }
    
    override var analyticsScreenName:String
    {
        get
        {
            return "Eye Authorization"
        }
    }

    
    @IBOutlet weak var statusLabel:UILabel!
    @IBOutlet weak var successLabel:UILabel!
    @IBOutlet weak var successImageView:UIImageView!
    //@IBOutlet weak var aProgressView: UIProgressView!
    @IBOutlet weak var progressButton:ProgressButton!
    @IBOutlet weak var captureView: UIView!
    @IBOutlet weak var cancelButton:UIButton!
    @IBOutlet weak var doneButton:UIButton!
    @IBOutlet weak var continueScanButton:UIButton!
    
    @IBOutlet weak var focusTopImageView: UIImageView!
    @IBOutlet weak var focusBottomImageView: UIImageView!
    
    @IBOutlet weak var cornerImageView: UIImageView!
    @IBOutlet weak var successView: UIView!
    @IBOutlet weak var focusTopViewTopConstraint:NSLayoutConstraint!
    @IBOutlet weak var focusBottomViewBottomConstraint:NSLayoutConstraint!
    
    weak var eyeAuthCancelDelegate : EyeAuthProtocol?
    weak var eyeVerificationAdpaterDelegate : EyeVerificationAdpaterProtocol?
    
    var doneImgListArray:[UIImage] = []
    var mode:Mode = .verify
    var orgViewFrame:CGRect?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.progressButton.isHidden = true
        self.progressButton.layer.cornerRadius = self.progressButton.frame.width/2
        self.progressButton.clipsToBounds = true
        self.progressButton.showProgressIndicator = true
        self.progressButton.downloadPercentage = 0.0
        self.successView.isHidden = true
        self.successLabel.isHidden = true
        self.successImageView.isHidden = true
        
        self.cancelButton.isHidden = false
        self.doneButton.isHidden = true
        EyeAuthManager.sharedInstance.setCaptureView(self.captureView)
        EyeAuthManager.sharedInstance.eyeAuthDelegate = self
        EyeAuthManager.sharedInstance.setEVAuthSessionDelegate(self)
        self.loadImages("Donecheck")
        self.focusTopViewTopConstraint.constant = -241
        self.focusBottomViewBottomConstraint.constant = -221

        if (self.mode == .enrollment)
        {
            EyeAuthManager.sharedInstance.enrollUserForEyeVerification()
        }
        else
        {
            EyeAuthManager.sharedInstance.verifyUserForEyeVerification()
        }

    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
    }
    
    func loadImages(_ filenameStartingWith:String)
    {
        for countValue in 0...15
        {
            let strImageName : String = "\(filenameStartingWith)\(countValue).png"
            let image  = UIImage(named:strImageName)
            self.doneImgListArray.append(image!)
        }
    }
    
    func animateEyeScanView(_ view:UIView)
    {

        UIView.animate(withDuration: 1.0, delay: 0, options: [.repeat, .autoreverse], animations: {
            view.frame.origin.y = (self.view.frame.origin.y/2)-20
            }) { (finished) in
                view.layoutIfNeeded()
        }
        
    }

    func enrollmentSessionStarted(_ totalSteps: Int32)
    {
        //self.counterLabel.text = String(totalSteps)
        self.progressButton.isHidden = false
        self.progressButton.setTitle(String(totalSteps), for: UIControlState())
        
    }
    
    func enrollmentSessionCompleted(_ isFinished: Bool)
    {
        if (isFinished == false)
        {
            // Log.dlog("Continuing to Scan...")
            statusLabel.text = "Continuing to Scan..."
            EyeAuthManager.sharedInstance.continueAuthentication()
        }
        else
        {
            self.progressButton.downloadPercentage = 1.0
        }
    }
    
    func enrollmentProgressUpdated(_ completionRatio: Float, counter counterValue: Int32)
    {
        self.progressButton.setTitle(String(counterValue), for: UIControlState())
        //self.progressButton.hidden = (counterValue == 0)
        self.progressButton.downloadPercentage = CGFloat(completionRatio)*100
    }
    
    func eyeStatusChanged(_ newEyeStatus: EVEyeStatus)
    {
        switch newEyeStatus {
        case EVEyeStatus.noEye:
            self.progressButton.isHidden = true
            self.cornerImageView.isHidden = false
            self.animateFocusOFF()
            statusLabel.text = NSLocalizedString("Position your eyes in the window", comment: "")
        case EVEyeStatus.tooFar:
            self.progressButton.isHidden = true
            self.cornerImageView.isHidden = false
            self.animateFocusOFF()
            statusLabel.text = NSLocalizedString("Move closer", comment: "")
        case EVEyeStatus.okay:
            statusLabel.text = NSLocalizedString("Perfect", comment: "")
            //animate the white views
            self.progressButton.isHidden = false
            self.cornerImageView.isHidden = true
            self.animateFocusOn()
            
        }
    }

    func animateFocusOn()
    {
        UIView.animate(withDuration: 8.0, delay: 0, options: UIViewAnimationOptions.curveLinear, animations: {
            self.focusTopViewTopConstraint.constant = -20
            self.focusBottomViewBottomConstraint.constant = 0
            self.statusLabel.text = NSLocalizedString("", comment: "")
            }, completion: nil)
        
    }
    
    func animateFocusOFF()
    {
        UIView.animate(withDuration: 8.0, delay: 0, options: UIViewAnimationOptions.curveLinear, animations: {
            self.focusTopViewTopConstraint.constant = -241
            self.focusBottomViewBottomConstraint.constant = -221

            }, completion: nil)
        
    }
    
    func enrollmentSucceded()
    {
        self.successViews()
    }
    
    
    func enrollmentFailed(_ enrollmentResult:EVEnrollmentResult)
    {
        var failureMessage = ""
        switch(enrollmentResult)
        {
        case EVEnrollmentResultError:
            failureMessage = NSLocalizedString("We couldn't complete the scan. Please try again.", comment:"")
        case EVEnrollmentResultBadQuality:
            failureMessage = NSLocalizedString("We couldn't complete the scan. Check that the camera lens is clean and try again.", comment:"")
        case EVEnrollmentResultNoop:
            failureMessage = NSLocalizedString("We couldn't complete the scan. Make sure your eyes are centered on screen and try again.", comment:"")
        case EVEnrollmentResultHTTPError:
            failureMessage = NSLocalizedString("We couldn't complete the scan. Please try again.", comment:"")
        case EVEnrollmentResultBadMatch:
            failureMessage = NSLocalizedString("We couldn't complete the scan. Make sure your eyes are centered on screen and try again.", comment:"")
        case EVEnrollmentResultEyenessFailed:
            failureMessage = NSLocalizedString("We couldn't complete the scan. Please try again.", comment:"")
        case EVEnrollmentResultZeroImages:
            failureMessage = NSLocalizedString("We couldn't complete the scan. Please try again.", comment:"")
        case EVEnrollmentResultIncomplete:
            failureMessage = NSLocalizedString("We couldn't complete the scan. Please try again.", comment:"")
        case EVEnrollmentResultNoEyes:
            failureMessage = NSLocalizedString("We couldn't complete the scan. Make sure your eyes are centered on screen and try again.", comment:"")
        case EVEnrollmentResultLowLight:
            failureMessage = NSLocalizedString("We couldn't complete the scan due to low lighting. Find better lighting and try again.", comment:"")
        default:
            failureMessage = NSLocalizedString("We couldn't complete the scan. Please try again.", comment:"")
        }
        let userinfo:[String:String] = ([NSLocalizedDescriptionKey: failureMessage,
            NSLocalizedFailureReasonErrorKey: NSLocalizedString("Enrollment Failed", comment: ""),
            NSLocalizedRecoverySuggestionErrorKey: NSLocalizedString("Try again later", comment:"")])
        
        let error = NSError(domain: "EyeEnrollment", code: -100, userInfo: userinfo)
        self.displayEyeAuthError(error)
    }
    
    func enrollmentAborted(_ abortReason: EVAbortReason)
    {
        var abortMessage = ""
        switch(abortReason)
        {
            case EVAbortReasonSystemTimeout:
                abortMessage = NSLocalizedString("Could not continue as system timedout", comment:"")
            case EVAbortReasonUserCancel:
                abortMessage = NSLocalizedString("Could not continue as user cancelled the action", comment:"")
            case EVAbortReasonAppBackground:
                abortMessage = NSLocalizedString("Could not continue as the app got suspended", comment:"")
            case EVAbortReasonUnsupportedDevice:
                abortMessage = NSLocalizedString("Could not continue as this is not one the supported devices", comment:"")
            case EVAbortReasonLicenseInvalid:
                abortMessage = NSLocalizedString("Could not continue as the licnese is invalid", comment:"")
            case EVAbortReasonLicenseExpired:
                abortMessage = NSLocalizedString("Could not continue as the licnese is expired", comment:"")
            case EVAbortReasonLicenseLimited:
                abortMessage = NSLocalizedString("Could not continue as the licnese is limited", comment:"")
            case EVAbortReasonInternetRequired:
                abortMessage = NSLocalizedString("Could not continue as no internet is available", comment:"")
            case EVAbortReasonLowLighting:
                abortMessage = NSLocalizedString("Could not continue due to low lighting", comment:"")
            default:
                abortMessage = NSLocalizedString("Could not continue for unknown reasons", comment:"")
        }
        let userinfo:[String:String] = ([NSLocalizedDescriptionKey: abortMessage,
            NSLocalizedFailureReasonErrorKey: NSLocalizedString("Enrollment cancelled", comment: ""),
            NSLocalizedRecoverySuggestionErrorKey: NSLocalizedString("Try again later", comment:"")])
        
        let error = NSError(domain: NSLocalizedString("EyeEnrollment", comment: ""), code: -100, userInfo: userinfo)
        self.displayEyeAuthError(error)
    }
    
    func displayEyeAuthError(_ anError: Error)
    {
        let error = anError as NSError
        DispatchQueue.main.async(execute: { () -> Void in
            let alertController = UIAlertController(title: error.domain, message: "\(error.localizedDescription) (Error \(error.code))", preferredStyle: UIAlertControllerStyle.alert)
            if(error.localizedFailureReason == NSLocalizedString("Enrollment Failed", comment: "") )
            {
                self.addActionsToRetryAlertController(alertController, retryCompletion: {
                    EyeAuthManager.sharedInstance.enrollUserForEyeVerification()
                })
            }
            else
            {
                self.addActionsToErrorAlertController(alertController)
            }
            
            self.present(alertController, animated: true, completion: nil)
        })
    }
    
    func addActionsToErrorAlertController(_ alertController:UIAlertController)
    {
        let cancelAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (action) in
            self.cancelButtonTouched()
        }
        alertController.addAction(cancelAction)
    }
    
    func addActionsToRetryAlertController(_ alertController: UIAlertController, retryCompletion: @escaping () -> ()) {
        let retryAction = UIAlertAction(title: NSLocalizedString("Retry", comment: ""), style: UIAlertActionStyle.default, handler:
            {
                [weak self]
                (alert: UIAlertAction!) in
                if let _ = self
                {
                    retryCompletion()
                }
            })
        alertController.addAction(retryAction)
    }
    
    func verificationSucceded()
    {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelButtonTouched()
    {
        
        AnalyticsAgent.sharedInstance.trackButtonTapped(self.analyticsScreenName, buttonName: NSLocalizedString("Eye Auth Cancelled", comment: ""))
        EyeVerifyLoader.getEyeVerifyInstance().cancel()
        UserPreferences.sharedInstance.isEyeVerificationEnrollmentRequested = true
        self.eyeAuthCancelDelegate?.enrollmentCancelled()
    }
    
    @IBAction func continueButtonTouched()
    {
        AnalyticsAgent.sharedInstance.trackButtonTapped(self.analyticsScreenName, buttonName: NSLocalizedString("Eye Auth Continued", comment: ""))
        EyeAuthManager.sharedInstance.continueAuthentication()
    }
    
    func verificationFailed(_ verificationResult:EVVerifyResult)
    {
        var failureMessage = ""
        switch(verificationResult)
        {
        case EVVerifyResultNotMatch:
            failureMessage = NSLocalizedString("Eye verification failed due to bad match, please try again.", comment:"")
        case EVVerifyResultBadQuality:
            failureMessage = NSLocalizedString("Eye verification failed due to bad quality image, please try again.", comment:"")
        case EVVerifyResultLivenessFailed:
            failureMessage = NSLocalizedString("Eye verification failed due to liveness failed, please try again.", comment:"")
        case EVVerifyResultHTTPError:
            failureMessage = NSLocalizedString("Eye verification failed due to server error, please try again.", comment:"")
        case EVVerifyResultNoServerAuthData:
            failureMessage = NSLocalizedString("Eye verification failed as server auth failed, please try again.", comment:"")
        case EVVerifyResultNoServerAuthData:
            failureMessage = NSLocalizedString("Eye verification failed as the eyeness failed, please try again.", comment:"")
        case EVVerifyResultMatchWithEnroll:
            failureMessage = NSLocalizedString("Eye verification failed, please try again.", comment:"")
        case EVVerifyResultNoEnrollments:
            failureMessage = NSLocalizedString("Eye verification failed due to no enrollments, please try again.", comment:"")
        case EVVerifyResultKeyGenFailed:
            failureMessage = NSLocalizedString("Eye verification failed as no keys could be generated, please try again.", comment:"")
        case EVVerifyResultCannotComputeFeature:
            failureMessage = NSLocalizedString("Eye verification failed as cannot compute feature, please try again.", comment:"")
        case EVVerifyResultZeroImages:
            failureMessage = NSLocalizedString("Eye verification failed as no images found, please try again.", comment:"")
        default:
            failureMessage = NSLocalizedString("Eye verification failed for unknown reasons, please try again.", comment:"")
        }
        let userinfo:[String:String] = ([NSLocalizedDescriptionKey: failureMessage,
            NSLocalizedFailureReasonErrorKey: NSLocalizedString("Verification failed", comment: ""),
            NSLocalizedRecoverySuggestionErrorKey: NSLocalizedString("Try again later", comment:"")])
        
        let error = NSError(domain: NSLocalizedString("Eye verification Failed", comment:""), code: -100, userInfo: userinfo)
        DispatchQueue.main.async(execute: { () -> Void in
            let alertController = UIAlertController(title: error.domain, message: "\(error.localizedDescription) (Error \(error.code))", preferredStyle: UIAlertControllerStyle.alert)
        let retryAction = UIAlertAction(title: NSLocalizedString("Try again", comment:""), style: UIAlertActionStyle.default, handler:
            {
                [weak self]
                (alert: UIAlertAction!) in
                if let _ = self
                {
                    EyeAuthManager.sharedInstance.verifyUserForEyeVerification()
                }
            })
            alertController.addAction(retryAction)
            self.present(alertController, animated: true, completion: nil)
        })
    }
    
    func verificationAborted(_ abortReason: EVAbortReason)
    {
        var abortMessage = ""
        switch(abortReason)
        {
        case EVAbortReasonSystemTimeout:
            abortMessage = NSLocalizedString("Eye verification cancelled as system has timedout, please try again.", comment:"")
        case EVAbortReasonUserCancel:
            abortMessage = NSLocalizedString("Eye verification cancelled by the user, please try again.", comment:"")
        case EVAbortReasonAppBackground:
            abortMessage = NSLocalizedString("Eye verification cancelled as the app got suspended, please try again.", comment:"")
        case EVAbortReasonUnsupportedDevice:
            abortMessage = NSLocalizedString("Eye verification cancelled as this is not one of the supported devices, please try again.", comment:"")
        case EVAbortReasonLicenseInvalid:
            abortMessage = NSLocalizedString("Eye verification cancelled as the license is invalid, please try again.", comment:"")
        case EVAbortReasonLicenseExpired:
            abortMessage = NSLocalizedString("Eye verification cancelled as the license is invalid, please try again.", comment:"")
        case EVAbortReasonLicenseLimited:
            abortMessage = NSLocalizedString("Eye verification cancelled as the license is invalid, please try again.", comment:"")
        case EVAbortReasonInternetRequired:
            abortMessage = NSLocalizedString("Eye verification cancelled as no internet is available, please try again.", comment:"")
        case EVAbortReasonLowLighting:
            abortMessage = NSLocalizedString("Eye verification cancelled due to low lighting, please try again.", comment:"")
        default:
            abortMessage = NSLocalizedString("Eye verification cancelled for unknown reasons, please try again.", comment:"")
        }
        let userinfo:[String:String] = ([NSLocalizedDescriptionKey: abortMessage,
            NSLocalizedFailureReasonErrorKey: NSLocalizedString("Verification cancelled", comment: ""),
            NSLocalizedRecoverySuggestionErrorKey: NSLocalizedString("Eye verification cancelled", comment:"")])
        
        let error = NSError(domain: NSLocalizedString("Eye verification cancelled", comment: ""), code: -100, userInfo: userinfo)
        DispatchQueue.main.async(execute: { () -> Void in
            let alertController = UIAlertController(title: error.domain, message: "\(error.localizedDescription) (Error \(error.code))", preferredStyle: UIAlertControllerStyle.alert)
            let retryAction = UIAlertAction(title: NSLocalizedString("Try again", comment:""), style: UIAlertActionStyle.default, handler:
                {
                    [weak self]
                    (alert: UIAlertAction!) in
                    if let _ = self
                    {
                        EyeAuthManager.sharedInstance.verifyUserForEyeVerification()
                    }
                })
            alertController.addAction(retryAction)
            self.present(alertController, animated: true, completion: nil)
        })
        
    }
    
    func successViews()
    {
        DispatchQueue.main.async { 
            EyeAuthManager.sharedInstance.setCaptureView(self.captureView)
            EyeAuthManager.sharedInstance.eyeAuthDelegate = self
            self.statusLabel.isHidden = true
            self.cancelButton.isHidden = true
            self.cancelButton.isHidden = true
            self.cornerImageView.isHidden = true
            self.progressButton.isHidden = true
            self.successView.isHidden = false
            self.focusTopImageView.isHidden = true
            self.focusBottomImageView.isHidden = true
            self.doneButton.isHidden = false
            self.successLabel.isHidden = false
            self.successImageView.isHidden = false
        }
    }

    @IBAction func doneButtonTouched()
    {
        AnalyticsAgent.sharedInstance.trackButtonTapped(self.analyticsScreenName, buttonName: NSLocalizedString("Done", comment: ""))
        self.dismiss(animated: true, completion: {
            self.eyeVerificationAdpaterDelegate?.eyeVerificationAuthenticationCompleted()
        })
//        let nowStoryboard = UIStoryboard(name: "Now", bundle: nil)
//        let destinationController = nowStoryboard.instantiateViewController(withIdentifier: "NowHomeViewController") as! NowHomeViewController
//        
//        if let delegate = UIApplication.shared.delegate as? AppDelegate
//        {
//            delegate.displayViewController(nowStoryboard, destinationViewController: destinationController)
//        }
    }
    
    func verificationCancelled() {
        
    }

    func enrollmentCancelled() {
        
    }

}
