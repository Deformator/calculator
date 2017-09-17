//
//  ViewController.swift
//  calculator
//
//  Created by Andrii Damm on 2017-09-14.
//  Copyright © 2017 Stonned Dwarfs. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    /*    override func didReceiveMemoryWarning() {
     super.didReceiveMemoryWarning()
     // Dispose of any resources that can be recreated.
     }
     */
    
    @IBOutlet weak var screen: UILabel!
    
    var userStartTyping : Bool = false
    
    var totalResult = 0
    
    var firstDidgit : Double = 0
    var secondDigit : Double = 0
    
    @IBAction func pressedButton(_ sender: UIButton) {
        let title = sender.title(for: .selected)!
        if userStartTyping {
            let textOnScreen = screen.text!
            screen.text = textOnScreen + title
        } else {
            screen.text = title
            userStartTyping = true
        }
        
    }
    
    @IBAction func countResult(_ sender: UIButton) {
        userStartTyping = false
        let operand = Double(screen.text!)!
        let pressedSymbol = sender.currentTitle
        if (pressedSymbol != nil) {
            switch sender.currentTitle! {
            case "AC":
                screen.text = "0"
                firstDidgit = 0
                secondDigit = 0
                userStartTyping = false
            case "√":
                let resultOfOperation = sqrt(operand)
                screen.text = String(resultOfOperation)
            case "%":
                let resultOfOperation = operand / 100
                screen.text = String(resultOfOperation)
            case "+":
                firstDidgit = operand
                userStartTyping = false
            default:
                break
            }
        }
    }
    
    
}

