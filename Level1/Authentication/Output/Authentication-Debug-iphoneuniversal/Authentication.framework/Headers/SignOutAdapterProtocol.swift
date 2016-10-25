//
//  SignOutAdapterProtocol.swift
//  Authentication
//
//  Created by Jain, Vijay on 9/23/16.
//  Copyright © 2016 Visa Inc. All rights reserved.
//

import UIKit

public protocol SignOutAdapterProtocol: class
{
    func userWillSignOut(_ userId : String, errorHandler:@escaping (_ error:Error?) -> (), completion:@escaping ()->())
    func didSignOut()
}
