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

public extension FacebookProtocol where Self:UIViewController
{
    
    func shareViaFacebook(delegate:SocialShareAdaptor,sharedItem: ShareItem)
    {
        if(NetworkManager.sharedInstance.isConnectedToNetwork())
        {
            let urlLink = URL(string:"fb://")
            let isInstalled = UIApplication.shared.canOpenURL(urlLink!)
            if (!isInstalled)
            {
                if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeFacebook)
                {
                    self.dismiss(animated: true, completion: nil)
                    let facebooksheet = self.composeFacebooksheet(sharedItem: sharedItem, delegate: delegate)
                    DispatchQueue.main.async(execute: { 
                        self.present(facebooksheet, animated: true, completion: nil)
                    })
                }
                else
                {
                    let alert = UIAlertController(title: "Accounts", message: "Please login to your Facebook account to share.", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
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
   
    func composeFacebooksheet(sharedItem:ShareItem,delegate:SocialShareAdaptor) -> SLComposeViewController
    {
        let facebookheet:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
        
        if let text = sharedItem.text
        {
            facebookheet.setInitialText(text)
        }
        
        if let url = sharedItem.imageURL
        {
            if let imageUrl = URL(string: url)
            {
                if let imageData = NSData(contentsOf: imageUrl) as? Data
                {
                    let imageFromURL = UIImage(data: imageData)
                    facebookheet.add(imageFromURL)
                }
            }
        }
        
        if let url = sharedItem.url
        {
            facebookheet.add(URL(string: url))
        }
        
        facebookheet.completionHandler = { (result:SLComposeViewControllerResult) -> Void in
            switch result {
            case SLComposeViewControllerResult.cancelled:
                print("Cancelled")
                delegate.displayResultForFacebookShare(result: SocialShareResult.cancelled)
                
                
            case SLComposeViewControllerResult.done:
                print("Done")
                delegate.displayResultForFacebookShare(result: SocialShareResult.done)
                
            }
        }
        
        return facebookheet
    }
}
