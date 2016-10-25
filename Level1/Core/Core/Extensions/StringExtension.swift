//
//  StringExtension.swift
//  Core
//
//  Created by Hadkar, Soniya on 11/13/15.
//  Copyright © 2015 Visa Inc. All rights reserved.
//

import UIKit

extension String
{
    func insert(_ string:String,ind:Int) -> String {
        return  String(self.characters.prefix(ind)) + string + String(self.characters.suffix(self.characters.count-ind))
    }
}
