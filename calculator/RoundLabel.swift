//
//  RoundLabel.swift
//  calculator
//
//  Created by Andrii Damm on 2017-09-19.
//  Copyright © 2017 Stonned Dwarfs. All rights reserved.
//

import UIKit

@IBDesignable
class RoundLabel: UILabel {

    //setup "corner radius" attribute for RoundLabel objects to Attribute inspector
    @IBInspectable var cornerRadius : CGFloat = 0 {
        didSet {
            self.adjustsFontSizeToFitWidth = true
            self.layer.masksToBounds = true
            self.layer.cornerRadius = cornerRadius
        }
    }
}
