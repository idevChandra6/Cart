//
//  SocialShareAdaptor.swift
//  SocialShare
//
//  Created by Hadkar, Soniya on 9/29/16.
//  Copyright © 2016 VisaOMC. All rights reserved.
//

import UIKit
import Social
import MessageUI

public enum SocialShareResult
{
    case none
    case cancelled
    case done
    case failed
}

open class SocialShareAdaptor: NSObject, MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate
{
    
    let shareDelegate:ShareProtocol
    
    public weak var facebookAdapterDelegate:FacebookProtocol?
    public weak var twitterAdapterDelegate:TwitterProtocol?
    public weak var messageAdapterDelegate:MessageProtocol?
    public weak var emailAdapterDelegate:MailProtocol?
    
    
    // Create a MessageComposer
    let messageComposer = MessageComposer()
    
    // Create a MailComposer
    let mailComposer = MailComposer()
    
    public init(shareDelegate:ShareProtocol)
    {
        self.shareDelegate = shareDelegate
    }
    
    public func displayShareView(sharedItem:ShareItem)
    {
        DispatchQueue.main.async {
            self.shareDelegate.displayShareViewController(delegate: self, sharedItem:sharedItem)
        }
    }

    public func displayResultForFacebookShare(result:SocialShareResult)
    {
        DispatchQueue.main.async {
            self.facebookAdapterDelegate?.didShareViaFacebook(delegate: self,result: result)
        }
    }
    
    public func displayResultForTwitterShare(result:SocialShareResult)
    {
        DispatchQueue.main.async {
            self.twitterAdapterDelegate?.didShareViaTwitter(delegate: self,result: result)
        }
    }
    
    public func displayResultForEmailShare(result:SocialShareResult)
    {
        DispatchQueue.main.async {
            self.emailAdapterDelegate?.didShareViaEmail(delegate: self, result: result)
        }
    }
    
    public func displayResultForMessageShare(result:SocialShareResult)
    {
        DispatchQueue.main.async {
            self.messageAdapterDelegate?.didShareViaMessage(delegate: self, result: result)
        }
    }
    
    public func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?)
    {
        var emailResult : SocialShareResult = SocialShareResult.none
        switch result {
        case MFMailComposeResult.cancelled:
             emailResult = SocialShareResult.cancelled
        case MFMailComposeResult.saved:
             emailResult = SocialShareResult.done
        case MFMailComposeResult.sent:
             emailResult = SocialShareResult.done
        case MFMailComposeResult.failed:
             emailResult = SocialShareResult.failed
        }
        
        DispatchQueue.main.async {
            controller.dismiss(animated: true, completion: nil)
            self.emailAdapterDelegate?.didShareViaEmail(delegate: self, result: emailResult)
            
        }
        
    }
    
    public func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult)
    {
        var messageResult : SocialShareResult = SocialShareResult.none
        switch (result)
        {
        case MessageComposeResult.cancelled:
            messageResult = SocialShareResult.cancelled
        case MessageComposeResult.failed:
            messageResult = SocialShareResult.failed
        case MessageComposeResult.sent:
            messageResult = SocialShareResult.done
        }
        
        DispatchQueue.main.async {
            controller.dismiss(animated: true, completion: nil)
            self.messageAdapterDelegate?.didShareViaMessage(delegate: self, result: messageResult)
            
        }
    }
    
    
}
