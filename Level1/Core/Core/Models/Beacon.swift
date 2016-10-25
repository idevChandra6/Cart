//
//  SBBeacon.swift
//  Core
//
//  Created by Jain, Vijay on 11/29/15.
//  Copyright © 2015 Visa Inc. All rights reserved.
//

import UIKit
import CoreLocation

open class Beacon: NSObject
{
    public var id:String?
    public var name:String?
    public var beaconRegion:CLBeaconRegion?
    public var waitTimeIntervalInSec:TimeInterval = 0.1
    public var locationId:String?
    public var canCollectBeaconInfo:Bool = true
    public var userId:String?

    public var dateTimeEntered:Date?
    public var dateTimeExited:Date?
    public var detected:Bool = false
    public var ranged:Bool = false
    fileprivate var timer: Timer?
    
    override init()
    {
        super.init()
    }
    
    func startTimer()
    {
        self.timer = Timer.scheduledTimer(timeInterval: self.waitTimeIntervalInSec, target: self, selector: #selector(Beacon.timerExpired), userInfo: nil, repeats: false)
        self.canCollectBeaconInfo = false
        self.timer?.fire()
    }
    
    public func timerExpired()
    {
        self.canCollectBeaconInfo = true
    }
    
    public func encodeWithCoder(_ aCoder: NSCoder)
    {
        aCoder.encode(id, forKey:"id")
        aCoder.encode(name, forKey:"name")
        aCoder.encode(beaconRegion, forKey:"beaconRegion")
        aCoder.encode(waitTimeIntervalInSec, forKey:"waitTimeIntervalInSec")
        aCoder.encode(locationId, forKey:"locationId")
        aCoder.encode(canCollectBeaconInfo, forKey:"canCollectBeaconInfo")
        aCoder.encode(userId, forKey:"userId")
        aCoder.encode(dateTimeEntered, forKey:"dateTimeEntered")
        aCoder.encode(dateTimeExited, forKey:"dateTimeExited")
        aCoder.encode(detected, forKey:"detected")
        aCoder.encode(ranged, forKey:"ranged")
    }
    
    required public init(coder aDecoder: NSCoder)
    {
        self.id = aDecoder.decodeObject(forKey: "id") as? String
        self.name = aDecoder.decodeObject(forKey: "name") as? String
        self.beaconRegion = aDecoder.decodeObject(forKey: "beaconRegion") as? CLBeaconRegion
        self.waitTimeIntervalInSec = aDecoder.decodeDouble(forKey: "waitTimeIntervalInSec")
        self.locationId = aDecoder.decodeObject(forKey: "locationId") as? String
        self.canCollectBeaconInfo = aDecoder.decodeBool(forKey: "canCollectBeaconInfo")
        self.userId = aDecoder.decodeObject(forKey: "userId") as? String
        self.dateTimeEntered = aDecoder.decodeObject(forKey: "dateTimeEntered") as? Date
        self.dateTimeExited = aDecoder.decodeObject(forKey: "dateTimeExited") as? Date
        self.detected = aDecoder.decodeBool(forKey: "detected")
        self.ranged = aDecoder.decodeBool(forKey: "ranged")
    }

}
