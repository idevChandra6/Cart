//
//  DiscloseButton.swift
//  Core
//
//  Created by Minimol B I on 5/31/16.
//  Copyright © 2016 Visa Inc. All rights reserved.
//

import UIKit

class DiscloseButton: UIButton {

    init()
    {
        super.init(frame: CGRect.zero)
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        self.setImage(UIImage(named: "iconNext"), for: UIControlState())

    }
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
    }
}
