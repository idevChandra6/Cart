//
//  AuthUIProtocolExtension.swift
//  Authentication
//
//  Created by Jain, Vijay on 9/21/16.
//  Copyright © 2016 Visa Inc. All rights reserved.
//

import UIKit
import Core
import MessageUI

public extension MailProtocol where Self:UIViewController
{
    func shareViaEmail(delegate:SocialShareAdaptor, sharedItem: ShareItem)
    {
        if(NetworkManager.sharedInstance.isConnectedToNetwork())
        {
            let mailComposerViewController:MFMailComposeViewController = composeEmail(sharedItem: sharedItem, delegate: delegate)
            
            if (MFMailComposeViewController.canSendMail())
            {
                self.dismiss(animated: true, completion: nil)
                //mailComposer.shareDelegate = self
                //mailComposerViewController.navigationBar.tintColor = UIColor.white
                
                mailComposerViewController.mailComposeDelegate = delegate
                DispatchQueue.main.async(execute: {
                    self.present(mailComposerViewController, animated: true, completion: nil)
                })
                
            }
            else
            {
                // Let the user know if his/her device isn't able to send text messages
                let alert = UIAlertController(title: "Cannot Send Email", message: "Your device is not able to send e-mail.", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                DispatchQueue.main.async(execute: {
                    self.present(alert, animated: true, completion: nil)
                })
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
    
    func composeEmail(sharedItem:ShareItem, delegate:SocialShareAdaptor) -> MFMailComposeViewController
    {
        let mailComposerViewController = MFMailComposeViewController()
        
        if let text = sharedItem.text
        {
            mailComposerViewController.setMessageBody(text, isHTML: false)
            mailComposerViewController.setSubject(text)
        }
        
        if let urlString = sharedItem.url
        {
            mailComposerViewController.setMessageBody(urlString, isHTML: true)
        }

        if let urlImageString = sharedItem.imageURL
        {
            if let urlImage = URL(string: urlImageString)
            {
                if let imageData = NSData(contentsOf: urlImage) as? Data
                {
                    if let id = sharedItem.id
                    {
                        mailComposerViewController.addAttachmentData(imageData, mimeType: "image/png", fileName: "\(id).png")
                    }
                    
                }
            }
            
        }
        return mailComposerViewController
        
    }

   
}
