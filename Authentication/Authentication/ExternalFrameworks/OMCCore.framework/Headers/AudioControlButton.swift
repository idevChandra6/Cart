//
//  AudioControlButton.swift
//  Core
//
//  Created by Minimol B I on 6/1/16.
//  Copyright © 2016 Visa Inc. All rights reserved.
//

import UIKit

class AudioControlButton: UIButton {

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
    
    @IBInspectable var shouldPlay: Bool = false {
        didSet{
            //if set to should play pause button should be visible
            self.setImage(UIImage(named: shouldPlay ? "pause" : "play"), for: UIControlState())
            self.setImage(UIImage(named: shouldPlay ? "pause" : "play"), for: UIControlState.selected)
            self.setImage(UIImage(named: shouldPlay ? "pause" : "play"), for: UIControlState.highlighted)
        }
    }

}
