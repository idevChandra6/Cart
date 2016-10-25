//
//  NetworkManager.swift
//  Concierge
//
//  Created by Jain, Vijay on 3/16/16.
//  Copyright © 2016 Visa Inc. All rights reserved.
//

import UIKit
import SystemConfiguration

open class NetworkManager: NSObject
{
    
    public static let sharedInstance = NetworkManager()
    
    var reachability : Reachability?
    
    public func isConnectedToNetwork() -> Bool
    {
        var reachable = false
        
        self.reachability = Reachability()
        
        if self.reachability?.currentReachabilityStatus.hashValue != 0
        {
            reachable = true
        }
        else
        {
            reachable = false
        }
        
        return reachable
    }

}

