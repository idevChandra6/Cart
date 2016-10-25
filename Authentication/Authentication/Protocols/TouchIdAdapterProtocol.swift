//
//  TouchIdAdapterProtocol.swift
//  Authentication
//
//  Created by Jain, Vijay on 9/22/16.
//  Copyright © 2016 Visa Inc. All rights reserved.
//

import UIKit

public protocol TouchIdAdapterProtocol: class
{
    func downloadContentWithTouchId(errorHandler:@escaping (_ error:Error?) -> (), completion:@escaping ()->())
    func touchIdAuthenticationCompleted()
    func userNotEqippedWithTouchId()
    func touchIdAuthenticationFailed(error anError:Error)
    func touchIdAuthenticationCancelled()

}
