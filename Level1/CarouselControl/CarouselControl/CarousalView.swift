//
//  StrategyView.swift
//  FidelityFundManagement
//
//  Created by Jain, Vijay on 7/27/16.
//  Copyright © 2016 Visa Inc. All rights reserved.
//

import UIKit

public protocol CarousalViewSelectionDelegate : class {
    func selectButtonTouched(index: Int)
}

open class CarousalView: UIView
{
    @IBOutlet weak var titleLabel:UILabel!
    @IBOutlet weak var imageView:UIImageView!
    @IBOutlet weak var subtitleLabel:UILabel!
    @IBOutlet weak var visualEffectView:UIVisualEffectView!
    @IBOutlet weak var selectButton:UIButton!
    
    var selected:Bool = false
    
    weak var delegate:CarousalViewSelectionDelegate?
    
    func setupCarousalView(title:String, subtitle:String, imageName:String)
    {
        self.titleLabel.text = title
        self.subtitleLabel.text = subtitle
        self.imageView.image = UIImage(named:imageName)
        self.visualEffectView.alpha = 0.0
    }
    
    @IBAction func selectButtonTouched()
    {
        self.delegate?.selectButtonTouched(index: self.tag)
        self.selected = false
        self.selectButton.setImage(UIImage(named: "SelectButton"), for: UIControlState.normal)
    }
}
