//
//  SBBeacon.swift
//  Core
//
//  Created by Jain, Vijay on 11/29/15.
//  Copyright © 2015 Visa Inc. All rights reserved.
//

import UIKit
import CoreLocation

class SBBeacon: NSObject
{
    var id:String?
    var name:String?
    var beaconRegion:CLBeaconRegion?
    var waitTimeIntervalInSec:TimeInterval = 0.1
    var locationId:String?
    var canCollectBeaconInfo:Bool = true
    var userId:String?

    var dateTimeEntered:Date?
    var dateTimeExited:Date?
    var detected:Bool = false
    var ranged:Bool = false
    fileprivate var timer: Timer?
    
    required override init()
    {
        super.init()
    }
    
    func startTimer()
    {
        self.timer = Timer.scheduledTimer(timeInterval: self.waitTimeIntervalInSec, target: self, selector: #selector(SBBeacon.timerExpired), userInfo: nil, repeats: false)
        self.canCollectBeaconInfo = false
        self.timer?.fire()
    }
    
    func timerExpired()
    {
        self.canCollectBeaconInfo = true
    }
    
    func encodeWithCoder(_ aCoder: NSCoder)
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
    
    required init(coder aDecoder: NSCoder)
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
