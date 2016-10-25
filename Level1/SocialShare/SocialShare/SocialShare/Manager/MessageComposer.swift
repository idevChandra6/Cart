//
//  MessageComposer.swift
//  Concierge
//
//  Created by Hadkar, Soniya on 6/2/16.
//  Copyright © 2016 Visa Inc. All rights reserved.
//

import Foundation
import MessageUI

//let textMessageRecipients = []

public class MessageComposer: NSObject, MFMessageComposeViewControllerDelegate
{
    //var shareDelegate:ShareProtocol
    var sharedItem:ShareItem?
    
    // A wrapper function to indicate whether or not a text message can be sent from the user's device
    func canSendText() -> Bool {
        return MFMessageComposeViewController.canSendText()
    }
    
    // Configures and returns a MFMessageComposeViewController instance
    func configuredMessageComposeViewController() -> MFMessageComposeViewController {
        
        let messageComposeVC = MFMessageComposeViewController()
//        messageComposeVC.messageComposeDelegate = self
        messageComposeVC.recipients = [] as? [String]
        
        
        return messageComposeVC
    }
    
    // MFMessageComposeViewControllerDelegate callback - dismisses the view controller when the user is finished with it
    public func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult)
    {
        switch (result.rawValue)
        {
        case MessageComposeResult.cancelled.rawValue:
            controller.dismiss(animated: true, completion: nil)
        case MessageComposeResult.failed.rawValue:
            controller.dismiss(animated: true, completion: nil)
        case MessageComposeResult.sent.rawValue:
            controller.dismiss(animated: true, completion: nil)
        default:
            break;
        }
       // self.shareDelegate?.dismiss()
    }
    
}
