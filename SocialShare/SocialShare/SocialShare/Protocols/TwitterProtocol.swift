//
//  TwitterProtocol.swift
//  SocialShare
//
//  Created by Hadkar, Soniya on 9/29/16.
//  Copyright © 2016 VisaOMC. All rights reserved.
//

import UIKit

public protocol TwitterProtocol: class
{
    func shareViaTwitter(delegate:SocialShareAdaptor,sharedItem: ShareItem)
    func didShareViaTwitter(delegate:SocialShareAdaptor,result:SocialShareResult)

}
