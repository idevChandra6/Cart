//
//  User.swift
//  OneMarket
//
//  Created by Jain, Vijay on 6/3/15.
//  Copyright (c) 2015 VISA. All rights reserved.
//

import UIKit
import CoreLocation

open class User: Contact
{
    public var accessToken:String?
    var keychainWrapper = KeychainWrapper()
    
    var transmittingBeacon:SBBeacon?

    public init(userId: String, accessToken: String)
    {
        super.init(userId:userId)
        self.accessToken = accessToken
    }
    
    public func createTransmissionBeacon(_ proximityUUD:String, major:Int, minor:Int)
    {
        self.transmittingBeacon = SBBeacon()
//        beacon.beaconRegion = CLBeaconRegion(proximityUUID: NSUUID(UUIDString: "D0D3FA86-CA76-45EC-9BD9-6AF45EBBE7FD")!, major: UInt16(18535), minor: UInt16(52593), identifier: "56e702888904781100ca6988")
        if let uid = self.uid
        {
            self.transmittingBeacon?.beaconRegion = CLBeaconRegion(proximityUUID: UUID(uuidString: proximityUUD)!, major: UInt16(major), minor: UInt16(minor), identifier: uid)
        }
    }

    
    public func Save()
    {
        let userData = NSKeyedArchiver.archivedData(withRootObject: self)
        UserDefaults.standard.set(userData, forKey: "LastUser")
        UserDefaults.standard.synchronize()
    }
    
    public class func retrieveLastUser() -> User?
    {
        var user:User? = nil
        if let userData =  UserDefaults.standard.object(forKey: "LastUser") as? Data
        {
            user = NSKeyedUnarchiver.unarchiveObject(with: userData) as? User
        }
        return user
    }
    
    public class func removeLastUser()
    {
        UserDefaults.standard.removeObject(forKey: "LastUser")
        UserDefaults.standard.synchronize()
    }
    
    override public func encode(with aCoder: NSCoder)
    {
        super.encode(with: aCoder)
        aCoder.encode(transmittingBeacon, forKey:"transmittingBeacon")
    
        self.keychainWrapper.mySetObject(accessToken, forKey:kSecValueData)
        self.keychainWrapper.writeToKeychain()
    }
    
    required public init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        self.transmittingBeacon = aDecoder.decodeObject(forKey: "transmittingBeacon") as? SBBeacon
        
             self.accessToken = self.keychainWrapper.myObject(forKey: "v_Data") as? String

    }
    
}
