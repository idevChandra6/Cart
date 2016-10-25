//
//  CustomSlider.swift
//  Core
//
//  Created by Minimol B I on 6/1/16.
//  Copyright © 2016 Visa Inc. All rights reserved.
//

import UIKit

class CustomSlider: UISlider {

    init() {
        super.init(frame: CGRect.zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setThumbImage(UIImage(named:"playhead" ), for: UIControlState())
        self.setThumbImage(UIImage(named:"playhead" ), for: UIControlState.highlighted)
        self.setThumbImage(UIImage(named:"playhead" ), for: UIControlState.disabled)
        self.setThumbImage(UIImage(named:"playhead" ), for: UIControlState.selected)
        self.setThumbImage(UIImage(named:"playhead" ), for: UIControlState.focused)
        self.setThumbImage(UIImage(named:"playhead" ), for: UIControlState.application)
        self.setThumbImage(UIImage(named:"playhead" ), for: UIControlState.reserved)
    }
 
}
