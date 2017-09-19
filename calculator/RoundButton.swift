//
//  RoundButton.swift
//  calculator
//
//  Created by Andrii Damm on 2017-09-19.
//  Copyright © 2017 Stonned Dwarfs. All rights reserved.
//

import UIKit

@IBDesignable
class RoundButton: UIButton {

    @IBInspectable var cornerRadius : CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    


}
