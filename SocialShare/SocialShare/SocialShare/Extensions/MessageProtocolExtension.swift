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
import MessageUI

public extension MessageProtocol where Self:UIViewController
{

    func shareViaMessage(delegate:SocialShareAdaptor, sharedItem:ShareItem)
    {
        if(NetworkManager.sharedInstance.isConnectedToNetwork())
        {
            if (MFMessageComposeViewController.canSendText())
            {
                self.dismiss(animated: true, completion: nil)
                //composer.shareDelegate = self
                //composer.sharedItem  = self.sharedItem
                let messageComposeVC = self.composeMessage(sharedItem: sharedItem, delegate: delegate)
                messageComposeVC.navigationBar.tintColor = UIColor.white
                messageComposeVC.messageComposeDelegate = delegate
                DispatchQueue.main.async(execute: {
                    self.present(messageComposeVC, animated: true, completion: nil)
                })
            }
            else
            {
                // Let the user know if his/her device isn't able to send text messages
                let alert = UIAlertController(title: "Cannot Send Text Message", message: "Your device is not able to send text messages.", preferredStyle: UIAlertControllerStyle.alert)
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
    
    func composeMessage(sharedItem:ShareItem, delegate:SocialShareAdaptor) -> MFMessageComposeViewController
    {
        let messageComposer = MFMessageComposeViewController()
        
        if let text = sharedItem.text
        {
            let messageBody = "\(text)"
            messageComposer.body = messageBody
        }
        
        if let imageUrl = sharedItem.imageURL
        {
            if let id = sharedItem.id
            {
                let data = try? Data(contentsOf: URL(string: imageUrl)!)
                messageComposer.addAttachmentData(data!, typeIdentifier: "kUTTypePNG", filename: "\(id).png")
            }
        }
        
        if let url = sharedItem.url
        {
            messageComposer.addAttachmentURL(URL(string: url)!, withAlternateFilename:nil )
        }
 
        return messageComposer
        
    }
}
