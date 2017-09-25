 /*
  * Name: Andrii Damm
  * Date: September 24, 2017
  * StudentID: 300966307
  * Description: Calculator
  * Version: 0.8 - Adding full functionality
  */

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
    
    
    var totalResult: Float = 0
    var firstOperand : Float = 0
    var secondOperand : Float = 0
    var userStartTyping : Bool = false
    var pressedOperator: String = ""
    var equalWasPressed = false
    var errorText = "No no no :)"
    
    
    @IBOutlet weak var screen: UILabel!
    
    
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
    
    
    @IBAction func dotButtonPressed(_ sender: UIButton) {
        if (noErrorsOnTheScreen()) {
            if (screen.text?.contains(".") == false) {
                screen.text = screen.text! + String(sender.currentTitle!)
                userStartTyping = true
            }
        }

    }
    
    @IBAction func pressResetButton(_ sender: UIButton) {
        screen.text = "0"
        reset()
    }
    
    
    @IBAction func symbolOperation(_ sender: UIButton) {
        userStartTyping = false
        if (noErrorsOnTheScreen()){
            let operand = Float(screen.text!)!
            let pressedSymbol = sender.currentTitle
            if (pressedSymbol != nil) {
                switch sender.currentTitle! {
                case "√":
                    let resultOfOperation = sqrt(operand)
                    if (resultOfOperation.isNaN) {
                        screen.text = errorText
                        userStartTyping = false
                    } else {
                        screen.text = String(resultOfOperation)
                    }
                case "%":
                    let resultOfOperation = operand / 100
                    screen.text = String(resultOfOperation)
                default:
                    break
                }
            }
        }

    }
    
    @IBAction func mathPerforming(_ sender: UIButton) {
        equalWasPressed = false
        userStartTyping = false
        if(noErrorsOnTheScreen()) {
          firstOperand = Float(screen.text!)!
        }
        
        pressedOperator = sender.currentTitle!
        
    }
    
    
    @IBAction func equalPressed(_ sender: UIButton) {
        if (equalWasPressed == false) {
            if (noErrorsOnTheScreen()){
                secondOperand = Float(screen.text!)!
                equalWasPressed = true
            }

        }
        
        switch pressedOperator {
        case "+":
            let result = firstOperand + secondOperand
            screen.text = forTailingZero(temp: result)
            firstOperand = Float(screen.text!)!
        case "﹣":
            let result = firstOperand - secondOperand
            screen.text = forTailingZero(temp: result)
            firstOperand = Float(screen.text!)!
        case "÷":
            if(secondOperand == 0) {
                screen.text = errorText
                userStartTyping = false
            } else {
                let result = firstOperand / secondOperand
                screen.text = forTailingZero(temp: result)
                firstOperand = Float(screen.text!)!
            }
        case "x":
            let result = firstOperand * secondOperand
            screen.text = forTailingZero(temp: result)
            firstOperand = Float(screen.text!)!
        default:
            break
        }

    }
    
    func forTailingZero(temp: Float) -> String {
        let tempVar = String(format: "%g", temp)
        return tempVar
    }
    
    func noErrorsOnTheScreen() -> Bool {
        if (screen.text == errorText) {
            screen.text = errorText
            reset()
            return false
            
        }
        else {
            return true
        }
    }
    
    func reset() {
        firstOperand = 0
        secondOperand = 0
        userStartTyping = false
        equalWasPressed = false
        pressedOperator = ""
    }

    
}

