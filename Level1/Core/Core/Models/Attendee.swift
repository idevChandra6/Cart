//
//  SBAttendee.swift
//  Core
//
//  Created by Jain, Vijay on 11/7/15.
//  Copyright © 2015 Visa Inc. All rights reserved.
//

import UIKit

open class Attendee: Contact
{
    public var title:String?
    public var companions:[Attendee]?
    public var isCompanion:Bool = false
    public var companionAttendeeUUID:String?
    public var attendeeUUID:String?
    public var createdAtDate:String?
    
    public init()
    {
        super.init(userId:"")
    }
    
    override public func encode(with aCoder: NSCoder)
    {
        super.encode(with: aCoder)
        aCoder.encode(title, forKey:"title")
        aCoder.encode(companionAttendeeUUID, forKey:"companionAttendeeUUID")
        aCoder.encode(isCompanion, forKey: "isCompanion")
        aCoder.encode(companions, forKey:"companions")
        aCoder.encode(attendeeUUID, forKey:"attendeeUUID")
        aCoder.encode(createdAtDate, forKey: "createdAtDate")
    }
    
    required public init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        self.title = aDecoder.decodeObject(forKey: "title") as? String
        self.companionAttendeeUUID = aDecoder.decodeObject(forKey: "companionAttendeeUUID") as? String
        self.isCompanion = aDecoder.decodeBool(forKey: "isCompanion")
        self.companions = aDecoder.decodeObject(forKey: "companions") as? [Attendee]
        self.attendeeUUID = aDecoder.decodeObject(forKey: "attendeeUUID") as? String
        self.createdAtDate = aDecoder.decodeObject(forKey: "createdAtDate") as? String
    }
}
