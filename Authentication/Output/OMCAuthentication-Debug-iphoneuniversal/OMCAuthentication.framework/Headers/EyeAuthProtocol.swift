//
//  EyeAuthProtocol.swift
//  Core
//
//  Created by Jain, Vijay on 9/19/16.
//  Copyright © 2016 Visa Inc. All rights reserved.
//

import UIKit

protocol EyeAuthProtocol: class
{
    func enrollmentSucceded()
    func enrollmentFailed(_ result:EVEnrollmentResult)
    func enrollmentAborted(_ abortReason: EVAbortReason)
    func enrollmentCancelled()
    
    func verificationSucceded()
    func verificationFailed(_ result:EVVerifyResult)
    func verificationAborted(_ abortReason: EVAbortReason)
    func verificationCancelled()
}
