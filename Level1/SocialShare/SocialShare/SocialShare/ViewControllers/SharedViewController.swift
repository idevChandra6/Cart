//
//  SharedViewController.swift
//  Concierge
//
//  Created by Hadkar, Soniya on 5/24/16.
//  Copyright © 2016 Visa Inc. All rights reserved.
//

import UIKit
import Social
import Core
import MessageUI

public class SharedViewController: BaseViewController
{
    
    weak var shareAdapterDelegate:SocialShareAdaptor?
    
    @IBOutlet weak var shareToFacebookBtn:UIButton!
    @IBOutlet weak var shareToTwitterBtn:UIButton!
    @IBOutlet weak var shareToEmailBtn:UIButton!
    @IBOutlet weak var shareToMessageBtn:UIButton!
    @IBOutlet weak var downloadBtn:UIButton!
    @IBOutlet weak var closeBtn:UIButton!
    @IBOutlet weak var tapGesture:UITapGestureRecognizer!
    
    fileprivate var sharedItem:ShareItem?
    
    public func setShare(_ sharedItem: ShareItem)
    {
        self.sharedItem = sharedItem
    }
    
    override public var analyticsScreenName:String
        {
        get
        {
            return "Shared"
        }
    }
    
    override public func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
        
       if(self.sharedItem?.type == .event)
        {
            self.downloadBtn.isHidden = true
        }
        else
        {
            self.downloadBtn.isHidden = false
        }
    }
    
    override public func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func shareToFacebookBtnTouched(_ sender:UIButton)
    {
        if let delegate = self.shareAdapterDelegate
        {
            if let shareItem = self.sharedItem
            {
                delegate.facebookAdapterDelegate?.shareViaFacebook(delegate: delegate, sharedItem: shareItem)
            }
            
        }
        //AnalyticsAgent.sharedInstance.trackButtonTapped(self.analyticsScreenName, buttonName: NSLocalizedString("SharedOnFacebook", comment: ""))
        
    }
    
    @IBAction func shareToTwitterBtnTouched(_ sender:UIButton)
    {
        if let delegate = self.shareAdapterDelegate
        {
            if let shareItem = self.sharedItem
            {
                delegate.twitterAdapterDelegate?.shareViaTwitter(delegate: delegate, sharedItem: shareItem)
            }
        }
        //AnalyticsAgent.sharedInstance.trackButtonTapped(self.analyticsScreenName, buttonName: NSLocalizedString("SharedOnTwitter", comment: ""))
    }
    
    
    @IBAction func shareToEmailBtnTouched(_ sender:UIButton)
    {
        if let delegate = self.shareAdapterDelegate
        {
            if let shareItem = self.sharedItem
            {
                delegate.emailAdapterDelegate?.shareViaEmail(delegate: delegate, sharedItem: shareItem)
            }
        }
        //AnalyticsAgent.sharedInstance.trackButtonTapped(self.analyticsScreenName, buttonName: NSLocalizedString("SharedByEmail", comment: ""))
        
        
    }
    
    @IBAction func shareToMessageBtnTouched(_ sender:UIButton)
    {
        if let delegate = self.shareAdapterDelegate
        {
            if let shareItem = self.sharedItem
            {
                delegate.messageAdapterDelegate?.shareViaMessage(delegate: delegate, sharedItem:shareItem)
            }
        }

        //AnalyticsAgent.sharedInstance.trackButtonTapped(self.analyticsScreenName, buttonName: NSLocalizedString("SharedByMessage", comment: ""))
        
    }
    
    @IBAction func shareToDownloadBtnTouched(_ sender:UIButton)
    {
        AnalyticsAgent.sharedInstance.trackButtonTapped(self.analyticsScreenName, buttonName: NSLocalizedString("Download", comment: ""))
        
        
         if(NetworkManager.sharedInstance.isConnectedToNetwork())
        {
            DispatchQueue.main.async
            {
                if let imageURLString = self.sharedItem?.imageURL
                {
                    if let imageURL = URL(string: imageURLString)
                    {
                        if let data = try? Data(contentsOf: imageURL)
                        {
                            if let imageData = UIImage(data: data)
                            {
                                UIImageWriteToSavedPhotosAlbum(imageData, nil, nil, nil)
                            }
                        }
                    }
                }
            }
            self.dismiss(animated: true, completion: nil)
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
    
    @IBAction func tapGesture(_ sender:UITapGestureRecognizer)
    {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func closeBtnTouched(_ sender:UIButton)
    {
        self.dismiss(animated: true, completion: nil)
    }
    
    func dismiss() {
        self.dismiss(animated: true, completion: nil)
        
    }
    
}
