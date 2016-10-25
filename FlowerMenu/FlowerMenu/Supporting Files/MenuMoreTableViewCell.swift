//
//  MenuMoreTableViewCell.swift
//  Concierge
//
//  Created by Jain, Vijay on 4/29/16.
//  Copyright © 2016 Visa Inc. All rights reserved.
//

import UIKit

class MenuMoreTableViewCell: UITableViewCell
{
    @IBOutlet weak var titleLabel:UILabel!
    
    func setupTitle(_ title:String)
    {
        self.titleLabel.text = title
    }
}
