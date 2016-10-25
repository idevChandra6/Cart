//
//  ShareDelegate.swift
//  SocialShare
//
//  Created by Hadkar, Soniya on 9/29/16.
//  Copyright © 2016 VisaOMC. All rights reserved.
//

import UIKit

public protocol ShareProtocol: class {
        func dismiss()
        func displayShareViewController(delegate:SocialShareAdaptor,sharedItem:ShareItem)
}
