//
//  CameraAdaptor.swift
//  Camera
//
//  Created by Hadkar, Soniya on 10/05/16.
//  Copyright © 2016 VisaOMC. All rights reserved.
//

import UIKit

public enum CameraResult
{
    case none
    case cancelled
    case done
    case failed
}

open class CameraAdaptor: NSObject 
{
    
    let cameraDelegate:CameraProtocol
    
    public init(cameraDelegate:CameraProtocol)
    {
        self.cameraDelegate = cameraDelegate
    }
    
    public func displayCameraView()
    {
        DispatchQueue.main.async {
            self.cameraDelegate.displayCameraView(delegate: self)
        }
    }
    
    public func clickImage()
    {
        DispatchQueue.main.async { 
            self.cameraDelegate.clickImage()
        }
    }
    
//    public func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult)
//    {
//        var messageResult : SocialShareResult = SocialShareResult.none
//        switch (result)
//        {
//        case MessageComposeResult.cancelled:
//            messageResult = SocialShareResult.cancelled
//        case MessageComposeResult.failed:
//            messageResult = SocialShareResult.failed
//        case MessageComposeResult.sent:
//            messageResult = SocialShareResult.done
//        }
//        
//        DispatchQueue.main.async {
//            controller.dismiss(animated: true, completion: nil)
//            self.messageAdapterDelegate?.didShareViaMessage(delegate: self, result: messageResult)
//            
//        }
//    }
    
    
}
