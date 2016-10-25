//
//  ShareItem.swift
//  Concierge
//
//  Created by Hadkar, Soniya on 6/2/16.
//  Copyright © 2016 Visa Inc. All rights reserved.
//

import UIKit

public enum ShareType
{
    case event
    case map
    case image
    case url
    case all
}


public class ShareItem: NSObject
{    
    public var text: String?
    public var imageURL: String?
    public var url: String?
    public var id:String?
    public var type:ShareType?
}
