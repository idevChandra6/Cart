//
//  SignInDelegate.swift
//  Flow
//
//  Created by Jain, Vijay on 9/15/15.
//  Copyright © 2015 Jain, Vijay. All rights reserved.
//

import Foundation

public protocol AuthUIProtocol: class {
    
    func displaySignInViewController(delegate:SignInAdapterProtocol)
    func displayTouchIdViewController(delegate:TouchIdAdapterProtocol)
    func displayEyeVeriifyViewController(delegate:EyeVerificationAdpaterProtocol)
}
