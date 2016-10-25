//
//  UserPreferencesExtension.swift
//  Authentication
//
//  Created by Jain, Vijay on 9/19/16.
//  Copyright © 2016 Visa Inc. All rights reserved.
//

import UIKit
import Core

extension UserPreferences
{
    var isEyeVerificationEnrollmentRequested: Bool
    {
        get
        {
            return UserDefaults.standard.bool(forKey: "EyeVerificationEnrollmentRequested")
        }
        set
        {
            UserDefaults.standard.set(newValue, forKey:"EyeVerificationEnrollmentRequested")
            UserDefaults.standard.synchronize()
        }
    }
}
