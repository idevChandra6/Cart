//
//  ProgressButton.swift
//  Core
//
//  Created by Minimol B I on 6/13/16.
//  Copyright © 2016 Visa Inc. All rights reserved.
//

import UIKit

open class ProgressButton: KAProgressButton {
    
    init()
    {
        super.init(frame: CGRect.zero)
    }
    
    required public init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    open var downloadPercentage: CGFloat = 0.0 {
        didSet {
            self.progress = CGFloat(downloadPercentage/100)
        }
    }
    
    public var showProgressIndicator = false {
        didSet {
            if showProgressIndicator {
            self.trackWidth = 5.0
            self.progressWidth = 5.0
            self.fillColor = UIColor.clear
            self.trackColor = UIColor.colorWithHexString("#51B964", alpha: 0.3)
            self.progressColor = UIColor.colorWithHexString("#51B964", alpha: 1.0)
            self.isStartDegreeUserInteractive = false
            self.isEndDegreeUserInteractive = false
            } else {
                self.trackWidth = 0.0
                self.progressWidth = 0.0
            }
        }
    }
}
