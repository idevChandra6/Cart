//
//  SBLocation.swift
//  Core
//
//  Created by Jain, Vijay on 10/16/15.
//  Copyright © 2015 Visa Inc. All rights reserved.
//

import UIKit
import CoreLocation

class SBLocation: NSObject, NSCoding
{
    var name:String?
    var event:String?
    var type:String?
    var location:CLLocation?
    var address: Address?
    var addressStr: String?
    var annotationImage:UIImage?
    
    func encode(with aCoder: NSCoder)
    {
        aCoder.encode(name, forKey:"name")
        aCoder.encode(event, forKey:"event")
        aCoder.encode(type, forKey:"type")
        aCoder.encode(location, forKey:"location")
        aCoder.encode(address, forKey:"address")
    }
    
    override init ()
    {
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        self.name = aDecoder.decodeObject(forKey: "name") as? String
        self.event = aDecoder.decodeObject(forKey: "event") as? String
        self.type = aDecoder.decodeObject(forKey: "type") as? String
        self.location = aDecoder.decodeObject(forKey: "location") as? CLLocation
        self.address = aDecoder.decodeObject(forKey: "address") as? Address
    }
    
    var streetAddress:String?
    {
        get {
            if let addressObj = address
            {
                return "\(addressObj.streetAddress!)"
            }
            else
            {
                return ""
            }
        }
    }
    var cityStateZipcode:String?
        {
        get {
            if let addressObj = address
            {
                return "\(addressObj.city!) \(addressObj.state!) \(addressObj.zipcode!)"
            }
            else
            {
                return ""
            }
        }
    }

    override var debugDescription: String
    {
        get
        {
            return " \(self.name)\n\(self.streetAddress)\n\(self.cityStateZipcode)"
        }
    }

}
