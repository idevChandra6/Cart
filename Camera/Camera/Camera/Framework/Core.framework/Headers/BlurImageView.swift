//
//  BlurImageView.swift
//  Core
//
//  Created by Minimol B I on 5/18/16.
//  Copyright © 2016 Visa Inc. All rights reserved.
//

import UIKit

class BlurImageView: UIImageView {

    init()
    {
        super.init(frame: CGRect.zero)
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        
//        let blur = UIBlurEffect(style: UIBlurEffectStyle.ExtraLight)
//        let effectView = UIVisualEffectView(effect: blur)
//        effectView.frame = self.frame
//        effectView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
//        self.addSubview(effectView)
    }
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
    }

}
