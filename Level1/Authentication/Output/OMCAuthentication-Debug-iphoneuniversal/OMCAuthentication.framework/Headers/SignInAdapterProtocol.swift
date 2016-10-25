//
//  SignInAdapterProtocol.swift
//  Authentication
//
//  Created by Jain, Vijay on 9/22/16.
//  Copyright © 2016 Visa Inc. All rights reserved.
//

import UIKit

public protocol SignInAdapterProtocol: class
{
    func downloadContentWithSignIn(errorHandler:@escaping (_ error:Error?) -> (), completion:@escaping ()->())
    func signInAuthenticationCompleted()
    func signInAuthenticationCancelled()
    func signInAuthenticationFailed(error anError:Error)
}
