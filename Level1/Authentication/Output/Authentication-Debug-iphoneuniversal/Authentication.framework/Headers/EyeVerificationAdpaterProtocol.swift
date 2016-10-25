//
//  EyeVerificationAdpaterProtocol.swift
//  Authentication
//
//  Created by Jain, Vijay on 9/23/16.
//  Copyright © 2016 Visa Inc. All rights reserved.
//

import UIKit

public protocol EyeVerificationAdpaterProtocol: class
{
    func downloadContentWithEyeVerification(errorHandler:@escaping (_ error:Error?) -> (), completion:@escaping ()->())
    func eyeVerificationAuthenticationCompleted()
    func eyeVerificationAuthenticationFailed(verifyResult result:EVVerifyResult)
    func eyeVerificationAuthenticationCancelled()
}
