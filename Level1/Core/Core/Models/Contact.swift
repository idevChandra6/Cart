//
//  Person.swift
//  OneMarket
//
//  Created by Vijay Jain on 5/28/15.
//  Copyright (c) 2015 VISA. All rights reserved.
//

import UIKit

open class Contact: NSObject, NSCoding {
 
    public var uid:String?
    public var firstName: String?
    public var lastName: String?
    public var givenName:String?

    public var companyName: String?
    public var companyLogoUrl:String?
    public var group: String?
    public var phones: [String:String]?
    public var emails: [String:String]?
    public var photoImageUrl:String?
    public var photo:UIImage?
    public var packageType:String?
    
    public var cardNumber:String?
    public var rewardPoints:String?
    public var role:String?
    
    public var selectedGift:String?
    
    
    public init (userId:String?)
    {
        super.init()
        self.uid = userId
    }
    
    public var displayName: String?
    {
        get
        {
            if (self.firstName != nil) && (self.lastName != nil)
            {
                 return "\(self.firstName!) \(self.lastName!)"
            }
            else if (self.givenName != nil)
            {
                return "\(self.givenName!)"
            }
            else if (self.firstName != nil)
            {
                 return "\(self.firstName!)"
            }
            else if (self.lastName != nil)
            {
                return "\(self.lastName!)"
            }
            else
            {
                return ""
            }
        }
    }
    
    
    public func encode(with aCoder: NSCoder)
    {
        aCoder.encode(uid, forKey:"uid")
        aCoder.encode(firstName, forKey:"firstName")
        aCoder.encode(lastName, forKey:"lastName")
        aCoder.encode(givenName, forKey:"givenName")
        aCoder.encode(companyName, forKey:"companyName")
        aCoder.encode(companyLogoUrl, forKey:"companyLogoUrl")
        aCoder.encode(group, forKey:"group")
        aCoder.encode(cardNumber, forKey:"cardNumber")
        aCoder.encode(rewardPoints, forKey:"rewardPoints")
        aCoder.encode(photoImageUrl, forKey:"photoImageUrl")
        aCoder.encode(photo, forKey:"photo")
        aCoder.encode(role, forKey:"role")
        aCoder.encode(packageType, forKey:"packageType")
        aCoder.encode(selectedGift, forKey:"selected_gift")
        if let phones = self.phones
        {
            aCoder.encode(phones, forKey:"phones")
        }
        if let emails = self.emails
        {
            aCoder.encode(emails, forKey:"emails")
        }
    }
        
    required public init(coder aDecoder: NSCoder)
    {
        self.uid = aDecoder.decodeObject(forKey: "uid") as? String
        self.firstName = aDecoder.decodeObject(forKey: "firstName") as? String
        self.lastName = aDecoder.decodeObject(forKey: "lastName") as? String
        self.givenName = aDecoder.decodeObject(forKey: "givenName") as? String
        self.companyName = aDecoder.decodeObject(forKey: "companyName") as? String
        self.companyLogoUrl = aDecoder.decodeObject(forKey: "companyLogoUrl") as? String
        self.group = aDecoder.decodeObject(forKey: "group") as? String
        self.cardNumber = aDecoder.decodeObject(forKey: "cardNumber") as? String
        self.rewardPoints = aDecoder.decodeObject(forKey: "rewardPoints") as? String
        self.photoImageUrl = aDecoder.decodeObject(forKey: "photoImageUrl") as? String
        self.photo = aDecoder.decodeObject(forKey: "photo") as? UIImage
        self.role = aDecoder.decodeObject(forKey: "role") as? String
        self.packageType = aDecoder.decodeObject(forKey: "packageType") as? String
        self.phones = aDecoder.decodeObject(forKey: "phones") as? [String:String]
        self.emails = aDecoder.decodeObject(forKey: "emails") as? [String:String]
        self.selectedGift = aDecoder.decodeObject(forKey: "selected_gift") as? String
    }
    
    override open var description:String
    {
        get
        {
            return "uid: \(self.uid!) name:\(self.displayName!)"
        }
    }
    

}
