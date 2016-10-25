//
//  AuthUIProtocolExtension.swift
//  Authentication
//
//  Created by Jain, Vijay on 9/21/16.
//  Copyright © 2016 Visa Inc. All rights reserved.
//

import UIKit

public extension ShareProtocol where Self:UIViewController
{
    func displayShareViewController(delegate:SocialShareAdaptor,sharedItem:ShareItem)
    {
        let frameworkBundle = Bundle(identifier: "com.visa.onemarket.SocialShare")
        let shareStoryboard = UIStoryboard(name: "Share", bundle: frameworkBundle)
        if let shareNavigationController = shareStoryboard.instantiateViewController(withIdentifier: "ShareNavigationController") as? UINavigationController
        {
            if let sharedViewController = shareNavigationController.viewControllers[0] as? SharedViewController
            {
                sharedViewController.shareAdapterDelegate = delegate
                sharedViewController.setShare(sharedItem)
                self.present(shareNavigationController, animated: true, completion: nil)
            }
        }

    }
    
}
