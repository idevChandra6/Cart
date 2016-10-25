//
//  SwitchButton.swift
//  Core
//
//  Created by Minimol B I on 5/11/16.
//  Copyright © 2016 Visa Inc. All rights reserved.
//

import UIKit

@IBDesignable

class SelectionButton: UIButton {

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
    
    @IBInspectable var selectStatus: Bool = false
        {
        
        didSet{
            self.setImage(UIImage(named: selectStatus ? "selected" : "select"), for: UIControlState())
        }
    }
}
