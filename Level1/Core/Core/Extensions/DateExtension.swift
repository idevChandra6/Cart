//
//  Date.swift
//  Core
//
//  Created by Jain, Vijay on 4/18/16.
//  Copyright © 2016 Visa Inc. All rights reserved.
//

import UIKit

extension Date
{
    func isLaterThanDate(_ dateToCompare: Date) -> Bool
    {
        var isLater = false
        
        if self.compare(dateToCompare) == ComparisonResult.orderedDescending
        {
            isLater = true
        }
        
        return isLater
    }
    
    func isEarlierThanDate(_ dateToCompare: Date) -> Bool
    {
        var isEarlier = false
        if self.compare(dateToCompare) == ComparisonResult.orderedAscending
        {
            isEarlier = true
        }
        
        return isEarlier
    }
    
    func equalToDate(_ dateToCompare: Date) -> Bool
    {
        var isEqualTo = false
        
        if self.compare(dateToCompare) == ComparisonResult.orderedSame {
            isEqualTo = true
        }
        
        return isEqualTo
    }
    
    static func dateFormatter(_ date: Date) -> String {
        let dFormatter = DateFormatter()
        dFormatter.dateFormat = "dd MMMM, yyyy"
        let dateString = dFormatter.string(from: date)
        return dateString
    }
    
}
