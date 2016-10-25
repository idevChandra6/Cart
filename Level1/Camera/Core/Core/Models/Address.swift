//
//  AddressDetails.swift
//  Core
//
//  Created by Hadkar, Soniya on 9/24/15.
//  Copyright © 2015 Visa Inc. All rights reserved.
//

import UIKit

class Address: NSObject, NSCoding {

    var streetAddress:String?
    var city:String?
    var state:String?
    var zipcode:String?
    var country:String?
    
    override init()
    {
        super.init()
    }
    
    func encode(with aCoder: NSCoder)
    {
        aCoder.encode(streetAddress, forKey:"streetAddress")
        aCoder.encode(city, forKey:"city")
        aCoder.encode(state, forKey:"state")
        aCoder.encode(zipcode, forKey:"zipcode")
        aCoder.encode(country, forKey:"country")
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        self.streetAddress = aDecoder.decodeObject(forKey: "streetAddress") as? String
        self.city = aDecoder.decodeObject(forKey: "city") as? String
        self.state = aDecoder.decodeObject(forKey: "state") as? String
        self.zipcode = aDecoder.decodeObject(forKey: "zipcode") as? String
        self.country = aDecoder.decodeObject(forKey: "country") as? String
    }

}
