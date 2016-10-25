//
//  FacebookProtocol.swift
//  SocialShare
//
//  Created by Hadkar, Soniya on 9/29/16.
//  Copyright © 2016 VisaOMC. All rights reserved.
//

import UIKit

public protocol FacebookProtocol: class
{
    func shareViaFacebook(delegate:SocialShareAdaptor,sharedItem: ShareItem)
    func didShareViaFacebook(delegate:SocialShareAdaptor,result:SocialShareResult)
    
}
