//
//  DisplayErrorProtocol.swift
//  Core
//
//  Created by Jain, Vijay on 9/15/16.
//  Copyright © 2016 Visa Inc. All rights reserved.
//

import UIKit

public protocol ErrorHandlingProtocol: class
{
    func display(error anError: ErrorProtocol)
    func display(error anError: Error?)
    func displayNetworkError(retry completion:(()->())?)
    func display(parsingError error: NSError)
    func display(timeoutError error: NSError)
    func display(serverError error: NSError)
    func display(authenticationError error: NSError)
}


