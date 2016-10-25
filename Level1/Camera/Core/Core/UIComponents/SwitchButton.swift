//
//  SwitchButton.swift
//  Core
//
//  Created by Minimol B I on 5/11/16.
//  Copyright © 2016 Visa Inc. All rights reserved.
//

import UIKit

@IBDesignable

class SwitchButton: UIButton {

    init()
    {
        super.init(frame: CGRect.zero)
    }

    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
    }
    
    @IBInspectable var switchStatus: Bool = false
        {
        
        didSet{
            self.setImage(UIImage(named: switchStatus ? "toggleOn" : "toggleOff"), for: UIControlState())
        }
    }
}
