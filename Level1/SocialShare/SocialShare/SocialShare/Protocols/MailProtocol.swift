//
//  TwitterProtocol.swift
//  SocialShare
//
//  Created by Hadkar, Soniya on 9/29/16.
//  Copyright © 2016 VisaOMC. All rights reserved.
//

import UIKit

public protocol MailProtocol: class
{
    func shareViaEmail(delegate:SocialShareAdaptor, sharedItem: ShareItem)
    func didShareViaEmail(delegate:SocialShareAdaptor,result:SocialShareResult)

}
