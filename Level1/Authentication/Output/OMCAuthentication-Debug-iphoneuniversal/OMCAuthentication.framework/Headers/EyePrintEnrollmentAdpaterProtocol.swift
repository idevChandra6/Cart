//
//  EyePrintEnrollmentAdpaterProtocol.swift
//  Authentication
//
//  Created by Jain, Vijay on 9/22/16.
//  Copyright © 2016 Visa Inc. All rights reserved.
//

import UIKit

public protocol EyePrintEnrollmentAdpaterProtocol: class
{
    func eyePrintEnrollmentCompleted()
    func eyePrintEnrollmentCancelled()
    func eyePrintEnrollmentFailed(enrollmentResult result:EVEnrollmentResult)
}
