//
//  HandleErrorProtocol.swift
//  Core
//
//  Created by Vijay Jain 09/21.2016.
//  Copyright © 2016 Visa Inc. All rights reserved.
//

import Foundation
import UIKit

public extension ErrorHandlingProtocol where Self:UIViewController
{
    public func display(error anError: ErrorProtocol)
    {
        DispatchQueue.main.async(execute: { () -> Void in
            let alertController = UIAlertController(title: "Protocol Not Implemented", message: "\(anError.errorDescription()) ", preferredStyle: UIAlertControllerStyle.alert)
            self.addActionsToErrorAlertController(alertController)
            self.present(alertController, animated: true, completion: nil)
        })
    }
    
    public func display(error anError: Error?)
    {
        if let error = anError as? NSError
        {
            switch (error.code)
            {
            case 401:
                self.display(authenticationError:error)
            case 403:
                self.handleInvalidTokenError()
            case 404:
                self.display(notFoundError:error)
                
            case 100006, 100003:
                self.display(genericError:error)
                
            case -1000, -100:
                self.display(parsingError:error)
            case -1001:
                
                let userinfo:[String:String] = ([NSLocalizedDescriptionKey: NSLocalizedString("Did not get a response from the server. Please try again.", comment: ""),
                                                 NSLocalizedFailureReasonErrorKey: NSLocalizedString("Timed out", comment: ""),
                                                 NSLocalizedRecoverySuggestionErrorKey: NSLocalizedString("Try again later",  comment: "")])
                
                let anError = NSError(domain: NSLocalizedString("Timeout Error", comment: ""), code: error.code, userInfo: userinfo)
                self.display(timeoutError:anError)
                
            case
            NSURLErrorCannotFindHost,
            NSURLErrorCannotConnectToHost,
            NSURLErrorNotConnectedToInternet,
            NSURLErrorSecureConnectionFailed,
            NSURLErrorServerCertificateHasBadDate,
            NSURLErrorServerCertificateUntrusted,
            NSURLErrorServerCertificateHasUnknownRoot,
            NSURLErrorServerCertificateNotYetValid,
            NSURLErrorClientCertificateRejected,
            NSURLErrorClientCertificateRequired,
            NSURLErrorCannotLoadFromNetwork,
            -1008,
            -1009,
            -1005:
                self.displayNetworkError(retry:nil)
                
            case NSURLErrorTimedOut:
                self.display(timeoutError:error)
                
            default:
                if error.code >= 400
                {
                    self.display(serverError:error)
                }
                else
                {
                    self.display(genericError:error)
                }
            }
        }
        //AnalyticsAgent.sharedInstance.trackError(self.analyticsScreenName, anError: anError)
    }
    
    public func display(genericError anError:NSError)
    {
        let error = anError as NSError
        DispatchQueue.main.async(execute: { () -> Void in
            let alertController = UIAlertController(title: error.domain, message: "\(error.localizedDescription) (Error \(error.code))", preferredStyle: UIAlertControllerStyle.alert)
            self.addActionsToErrorAlertController(alertController)
            self.present(alertController, animated: true, completion: nil)
        })
    }
    
    public func display(notFoundError anError:NSError)
    {
        if (ConfiguredEnv.canDisplayServerError == true)
        {
            let error = anError as NSError
            DispatchQueue.main.async(execute: { () -> Void in
                let alertController = UIAlertController(title: self.title, message: "\(error.localizedDescription) (Error \(error.code))", preferredStyle: UIAlertControllerStyle.alert)
                self.addActionsToErrorAlertController(alertController)
                self.present(alertController, animated: true, completion: nil)
            })
        }
    }
    
    public func displayNetworkError(retry completion:(()->())?)
    {
        DispatchQueue.main.async(execute: { () -> Void in
            let alertController = UIAlertController(title: NSLocalizedString("Network problem", comment: ""), message: NSLocalizedString("Network connection is not available. Please try again.", comment: ""), preferredStyle: UIAlertControllerStyle.alert)
            
            let cancelAction = UIAlertAction(title: NSLocalizedString("OK", comment:""), style: UIAlertActionStyle.default, handler: nil)
            alertController.addAction(cancelAction)
            
            if let completion = completion
            {
                self.addActionsToRetryAlertController(alertController, retryCompletion: completion)
            }
            self.present(alertController, animated: true, completion: nil)
        })
    }
    
    public func display(parsingError error: NSError)
    {
        if (ConfiguredEnv.canDisplayParsigError == true)
        {
            DispatchQueue.main.async(execute: { () -> Void in
                let alertController = UIAlertController(title: NSLocalizedString("Parsing error", comment: ""), message: "\(error.localizedDescription)", preferredStyle: UIAlertControllerStyle.alert)
                self.addActionsToErrorAlertController(alertController)
                self.present(alertController, animated: true, completion: nil)
            })
        }
        else
        {
            NSLog("Parsing Error: \(error.localizedDescription)")
        }
    }
    
    public func display(timeoutError error: NSError)
    {
        DispatchQueue.main.async(execute: { () -> Void in
            let errorMessage:String = error.localizedDescription
            let alertController = UIAlertController(title: NSLocalizedString("Please try again", comment: ""), message: errorMessage, preferredStyle: UIAlertControllerStyle.alert)
            self.addActionsToErrorAlertController(alertController)
            self.present(alertController, animated: true, completion: nil)
        })
    }
    
    public func display(serverError anError: NSError)
    {
        if (ConfiguredEnv.canDisplayServerError == true)
        {
            let error = anError as NSError
            DispatchQueue.main.async(execute: { () -> Void in
                let errorMessage: String = error.localizedDescription
                
                let alertController = UIAlertController(title: NSLocalizedString("Server error", comment: ""), message: "\(errorMessage) (Error \(error.code))", preferredStyle: UIAlertControllerStyle.alert)
                self.addActionsToErrorAlertController(alertController)
                
                self.present(alertController, animated: true, completion: nil)
            })
        }
        else
        {
            NSLog("Parsing Error: \(anError.localizedDescription)")
        }
    }
    
    public func display(authenticationError anError: NSError)
    {
        let title = "Authentication Error"
        let error = anError as NSError
        
        DispatchQueue.main.async(execute: { () -> Void in
            let errorMessage: String = error.localizedDescription
            
            let alertController = UIAlertController(title: title, message: "\(errorMessage) (Error \(error.code))", preferredStyle: UIAlertControllerStyle.alert)
            self.addActionsToErrorAlertController(alertController)
            
            self.present(alertController, animated: true, completion: nil)
        })
    }
    
    public func handleInvalidTokenError()
    {
        DispatchQueue.main.async(execute: { () -> Void in
            //self.displaySignInViewController()
        })
        
    }
    
    func addActionsToRetryAlertController(_ alertController:UIAlertController, retryCompletion:@escaping ()->())
    {
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
    
    func addActionsToErrorAlertController(_ alertController:UIAlertController)
    {
        let cancelAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
        alertController.addAction(cancelAction)
    }
    
}
