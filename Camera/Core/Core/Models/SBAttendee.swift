//
//  SBAttendee.swift
//  Core
//
//  Created by Jain, Vijay on 11/7/15.
//  Copyright © 2015 Visa Inc. All rights reserved.
//

import UIKit

class SBAttendee: Contact
{
    var title:String?
    var companions:[SBAttendee]?
    var isCompanion:Bool = false
    var companionAttendeeUUID:String?
    var attendeeUUID:String?
    var createdAtDate:String?
    
    required init()
    {
        super.init(userId:"")
    }
    
    override func encode(with aCoder: NSCoder)
    {
        super.encode(with: aCoder)
        aCoder.encode(title, forKey:"title")
        aCoder.encode(companionAttendeeUUID, forKey:"companionAttendeeUUID")
        aCoder.encode(isCompanion, forKey: "isCompanion")
        aCoder.encode(companions, forKey:"companions")
        aCoder.encode(attendeeUUID, forKey:"attendeeUUID")
        aCoder.encode(createdAtDate, forKey: "createdAtDate")
    }
    
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        self.title = aDecoder.decodeObject(forKey: "title") as? String
        self.companionAttendeeUUID = aDecoder.decodeObject(forKey: "companionAttendeeUUID") as? String
        self.isCompanion = aDecoder.decodeBool(forKey: "isCompanion")
        self.companions = aDecoder.decodeObject(forKey: "companions") as? [SBAttendee]
        self.attendeeUUID = aDecoder.decodeObject(forKey: "attendeeUUID") as? String
        self.createdAtDate = aDecoder.decodeObject(forKey: "createdAtDate") as? String
    }
}
