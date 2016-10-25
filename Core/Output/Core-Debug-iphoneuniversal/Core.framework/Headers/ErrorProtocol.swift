//
//  protocol AnalyticsErrorType: Error {     func errorDescription() -> String } ErrorProtocol.swift
//  Core
//
//  Created by Jain, Vijay on 9/19/16.
//  Copyright © 2016 Visa Inc. All rights reserved.
//

import UIKit

public protocol ErrorProtocol: Error
{
    func errorDescription() -> String
}
