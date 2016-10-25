//
//  TwitterProtocol.swift
//  SocialShare
//
//  Created by Hadkar, Soniya on 9/29/16.
//  Copyright © 2016 VisaOMC. All rights reserved.
//

import UIKit

public protocol MessageProtocol: class
{
    func shareViaMessage(delegate:SocialShareAdaptor, sharedItem:ShareItem)
    func didShareViaMessage(delegate:SocialShareAdaptor,result:SocialShareResult)
}
