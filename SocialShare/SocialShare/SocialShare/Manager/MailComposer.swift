//
//  MailComposer.swift
//  Concierge
//
//  Created by Hadkar, Soniya on 6/2/16.
//  Copyright © 2016 Visa Inc. All rights reserved.
//

import UIKit
import MessageUI

public class MailComposer: NSObject , MFMailComposeViewControllerDelegate
{
 
    //var shareDelegate:ShareProtocol
    var sharedItem:ShareItem?
    
    // A wrapper function to indicate whether or not a email can be sent from the user's device
    func canSendMail() -> Bool {
        return MFMailComposeViewController.canSendMail()
    }
    
    func configuredMailComposeViewController() -> MFMailComposeViewController
    {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        
//        if let sharedItem = self.sharedItem
//        {
//         /*   if (sharedItem.type == .itinerary)
//            {
//                if let text = sharedItem.text
//                {
//                   var messageBody = NSLocalizedString("I'm planning on attending ", comment: "") + "\(text)"
//                    if let url = sharedItem.url
//                    {
//                        messageBody = String("\(messageBody) \n \(url)")
//                    }
//                    
//                    mailComposerVC.setMessageBody( messageBody, isHTML: false)
//                    let messageSubject = NSLocalizedString("Visa Rio Update: ", comment: "") + "\(text)"
//                    mailComposerVC.setSubject(messageSubject)
//                    
//                    self.attachImage(mailComposerVC)
//                }
//            }
//            else if (sharedItem.type == .photo)
//            {
//                mailComposerVC.setSubject(String(NSLocalizedString("Check out my photo at the Rio 2016 Olympic Games", comment: "")))
//                self.attachImage(mailComposerVC)
//                
//            }
//            else if (sharedItem.type == .map)
//            {
//                if let text = sharedItem.text
//                {
//                    if let url = sharedItem.url
//                    {
//                        mailComposerVC.setMessageBody(text + " " + url, isHTML: true)
//                    }
//                    else
//                    {
//                        mailComposerVC.setMessageBody(text, isHTML: false)
//                    }
//                    mailComposerVC.setSubject(String(NSLocalizedString("Check this place out", comment: "")))
//                }
//                
//                self.attachImage(mailComposerVC)
//                
//              */
//            }
        
        return mailComposerVC
    }
    
    func attachImage(_ mailComposerVC:MFMailComposeViewController)
    {
        if let sharedItem = self.sharedItem
        {
            if let imageUrl = sharedItem.imageURL
            {
                if let id = sharedItem.id
                {
                    let data = try? Data(contentsOf: URL(string: imageUrl)!)
                    mailComposerVC.addAttachmentData(data!, mimeType: "image/png", fileName: "\(id).png")
                }
            }
        }
    }

    

}

