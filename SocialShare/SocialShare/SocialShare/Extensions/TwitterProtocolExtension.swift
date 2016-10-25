//
//  AuthUIProtocolExtension.swift
//  Authentication
//
//  Created by Jain, Vijay on 9/21/16.
//  Copyright © 2016 Visa Inc. All rights reserved.
//

import UIKit
import Social
import Core

public extension TwitterProtocol where Self:UIViewController
{
    func shareViaTwitter(delegate:SocialShareAdaptor,sharedItem: ShareItem)
    {
        if(NetworkManager.sharedInstance.isConnectedToNetwork())
        {
            if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeTwitter)
            {
                self.dismiss(animated: true, completion: nil)
                let twitterSheet = self.composeTwittersheet(sharedItem: sharedItem, delegate: delegate)
                
                DispatchQueue.main.async(execute: { 
                    self.present(twitterSheet, animated: true, completion: nil)
                })
                
            }
            else
            {
                let alert = UIAlertController(title: "Accounts", message: "Please login to a Twitter account to share.", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
        else
        {
            DispatchQueue.main.async(execute: {
                let alertController = UIAlertController(title: NSLocalizedString("No network connection", comment: ""), message: NSLocalizedString("Your device has no network connection. Please try again later.", comment: ""), preferredStyle: UIAlertControllerStyle.alert)
                let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
            })
        }
    }
    
    func composeTwittersheet(sharedItem:ShareItem,delegate:SocialShareAdaptor) -> SLComposeViewController
    {
        let twitterSheet:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
        
        if let text = sharedItem.text
        {
            twitterSheet.setInitialText(text)
        }
        
        if let url = sharedItem.imageURL
        {
            if let imageUrl = URL(string: url)
            {
                if let imageData = NSData(contentsOf: imageUrl) as? Data
                {
                    let imageFromURL = UIImage(data: imageData)
                    twitterSheet.add(imageFromURL)
                }
            }
        }
        
        if let url = sharedItem.url
        {
            twitterSheet.add(URL(string: url))
        }
        
        twitterSheet.completionHandler = { (result:SLComposeViewControllerResult) -> Void in
            switch result {
            case SLComposeViewControllerResult.cancelled:
                print("Cancelled")
                delegate.displayResultForTwitterShare(result: SocialShareResult.cancelled)
                
                
            case SLComposeViewControllerResult.done:
                print("Done")
                delegate.displayResultForTwitterShare(result: SocialShareResult.done)
                
            }
        }
        
        return twitterSheet
    }
}
