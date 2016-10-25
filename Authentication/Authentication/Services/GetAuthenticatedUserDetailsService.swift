//
//  GetAuthenticatedUserDetails.swift
//  Authentication
//
//  Created by Jain, Vijay on 11/10/15.
//  Copyright © 2015 Visa Inc. All rights reserved.
//

import UIKit
import OMCCore

class GetAuthenticatedUserDetailsService: BaseService
{
    
    enum ParseError: BaseParsingErrorType
    {
        case userDetailsMissing
        case userIdMissing
        case userFirstNameMissing
        case userLastNameMissing
        case userCompanyNameMissing
        case userTitleMissing
        case userPhotoURLMissing
        case packageTypeMissing
        case userRoleMissing
        case proximityUUIDMissing
        case majorMissing
        case majorInvalidValue
        case minorMissing
        case minorInvalidValue
        
        
        func errorDescription() -> String
        {
            switch (self)
            {
            case .userDetailsMissing:
                return NSLocalizedString("User details are missing", comment: "")
            case .userFirstNameMissing:
                return NSLocalizedString("User first name is missing", comment: "")
            case .userLastNameMissing:
                return NSLocalizedString("User last name is missing", comment: "")
            case .userCompanyNameMissing:
                return NSLocalizedString("User company name missing", comment: "")
            case .userTitleMissing:
                return NSLocalizedString("User title is missing", comment: "")
            case .userPhotoURLMissing:
                return NSLocalizedString("User photo URL is missing", comment: "")
            case .packageTypeMissing:
                return NSLocalizedString("PackageType is missing", comment: "")
            case .userRoleMissing:
                return NSLocalizedString("User role is missing", comment: "")
            case .userIdMissing:
                return NSLocalizedString("User ID is missing", comment: "")
            case .proximityUUIDMissing:
                return NSLocalizedString("Proximity UUID is missing", comment: "")
            case .majorMissing:
                return NSLocalizedString("Major is missing", comment: "")
            case .majorInvalidValue:
                return NSLocalizedString("Major has invalid vaiue", comment: "")
            case .minorMissing:
                return NSLocalizedString("Minor is missing", comment: "")
            case .minorInvalidValue:
                return NSLocalizedString("Minor has invalid vaiue", comment: "")
            }
        }
    }
    
    func getUserDetails(_ errorHandler:@escaping (_ error:Error?) -> (), completionHandler:@escaping ()->())
    {
        let requestUrl = ConfiguredEnv.sharedInstance.baseVersionedApiUrl + "users/details"
        let accessToken = AuthManager.sharedInstance.authenticatedUser?.accessToken
        self.sendRequest(requestUrl, accessToken:accessToken, errorHandler:errorHandler, completionHandler:completionHandler)
    }
    
    override func parseResponseDictionary(_ userDetails: NSDictionary) throws
    {
        if let user = AuthManager.sharedInstance.authenticatedUser
        {
            guard let firstName = userDetails["first_name"] as? String else
            {
                throw ParseError.userFirstNameMissing
            }
            user.firstName = firstName
            
            guard let lastName = userDetails["last_name"] as? String else
            {
                throw ParseError.userLastNameMissing
            }
            user.lastName = lastName
            
            if let company = userDetails["company"] as? String
            {
                user.companyName = company
            }
            
            if let imageUrl = userDetails["image_url"] as? String
            {
                user.photoImageUrl = imageUrl
            }
            
            guard let role = userDetails["role"] as? String else
            {
                throw ParseError.userRoleMissing
            }
            user.role = role
            
            guard let packageType = userDetails["package_type"] as? String else
            {
                throw ParseError.packageTypeMissing
            }
            user.packageType = packageType
            
            if(user.packageType?.lowercased() == "consumer")
            {
                let localeStrings = NSLocale.current.identifier.components(separatedBy: "_")
                if(localeStrings[0] == "es")
                {
                    BundleLocalization.sharedInstance().language = "es"
                }
                else if(localeStrings[0] == "pt")
                {
                    BundleLocalization.sharedInstance().language = "pt"
                }
                else
                {
                    BundleLocalization.sharedInstance().language = "en"
                }
            }
            else
            {
                BundleLocalization.sharedInstance().language = "en"
            }

            guard let proximityUUID = userDetails["proximity_uuid"] as? String else
            {
                throw ParseError.proximityUUIDMissing
            }

            guard let major = userDetails["major"] as? String else
            {
                throw ParseError.majorMissing
            }
            guard let majorInt = Int(major) , majorInt > 0 else
            {
                throw ParseError.majorInvalidValue
            }
            guard let minor = userDetails["minor"] as? Int else
            {
                throw ParseError.minorMissing
            }
            user.createTransmissionBeacon(proximityUUID, major: majorInt, minor: minor)

            guard let userId = userDetails["id"] as? String else
            {
                throw ParseError.userIdMissing
            }
            user.uid = String(userId)
            
            if let selectedGift = userDetails["selected_gift"] as? String
            {
                user.selectedGift = selectedGift
            }
            
            if let authenticatedUser  = AuthManager.sharedInstance.authenticatedUser
            {
                AnalyticsAgent.sharedInstance.trackLogin(authenticatedUser:authenticatedUser)
            }
            
            user.Save()
        }
    }
}
