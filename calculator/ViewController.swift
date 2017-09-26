 /*
  * Name: Andrii Damm
  * Date: September 24, 2017
  * StudentID: 300966307
  * Description: Calculator
  * Version: 0.95 - Swift docs
  */

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    //variables for performing buttons sounds
    var buttonClickSound : AVAudioPlayer = AVAudioPlayer()
    var operatorClickSound : AVAudioPlayer = AVAudioPlayer()
    var resetCLickSound : AVAudioPlayer = AVAudioPlayer()
    var resultClickSound : AVAudioPlayer = AVAudioPlayer()

    //operands and operator for performing math
    var firstOperand : Float = 0
    var secondOperand : Float = 0
    var pressedOperator: String = ""
    
    //flags for user's interaction
    var userStartTyping : Bool = false
    var equalWasPressed = false
    
    //error for unacceptable math operations
    var errorText = "No no no :)"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //path to the sound files and attaching them to AudioPlayer variables
        let operandButtonSound =  Bundle.main.path(forResource: "buttonSound", ofType: ".mp3")
        let operatorButtonSound = Bundle.main.path(forResource: "operatorSound", ofType: ".mp3")
        let resetButtonSound = Bundle.main.path(forResource: "resetSound", ofType: ".mp3")
        let resultButtonSound = Bundle.main.path(forResource: "resultSound", ofType: ".mp3")

        do {
            try buttonClickSound = AVAudioPlayer(contentsOf: URL(fileURLWithPath: operandButtonSound!))
            try operatorClickSound = AVAudioPlayer(contentsOf: URL(fileURLWithPath: operatorButtonSound!))
            try resetCLickSound = AVAudioPlayer(contentsOf: URL(fileURLWithPath: resetButtonSound!))
            try resultClickSound = AVAudioPlayer(contentsOf: URL(fileURLWithPath: resultButtonSound!))
        }
        catch {
            print(error)
        }
    }
    
    //main screen
    @IBOutlet weak var screen: UILabel!
    
    //button handler for "0-9" buttons which display a pressed button on the screen
    @IBAction func pressedButton(_ sender: UIButton) {
        buttonClickSound.play()
        
        let title = sender.title(for: .selected)!
        if userStartTyping {
            let textOnScreen = screen.text!
            screen.text = textOnScreen + title
        } else {
            screen.text = title
            userStartTyping = true
        }
    }
    
    //button handler for "." button which responsible for decimal operations
    @IBAction func dotButtonPressed(_ sender: UIButton) {
        buttonClickSound.play()
        
        if (noErrorsOnTheScreen()) {
            if (userStartTyping == true && screen.text?.contains(".") == false) {
                screen.text = screen.text! + String(sender.currentTitle!)
            } else if (screen.text == "0"){
                screen.text = screen.text! + String(sender.currentTitle!)
                userStartTyping = true
            }
        }
    }
    
    //button handler for "AC" button which reset all operations and set screen to "0" value
    @IBAction func pressResetButton(_ sender: UIButton) {
        resetCLickSound.play()
        
        screen.text = "0"
        reset()
    }
    
    //button handler for "√" and "%" buttons (square root and percentage operations)
    @IBAction func symbolOperation(_ sender: UIButton) {
        resultClickSound.play()
        
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
                        screen.text = forTailingZero(temp: resultOfOperation)
                    }
                case "%":
                    let resultOfOperation = operand / 100
                    screen.text = forTailingZero(temp: resultOfOperation)
                default:
                    break
                }
            }
        }
    }
    
    //button handler for "+","-","÷" and "x" buttons to perform math operations
    @IBAction func mathPerforming(_ sender: UIButton) {
        operatorClickSound.play()
        
        equalWasPressed = false
        userStartTyping = false
        if(noErrorsOnTheScreen()) {
          firstOperand = Float(screen.text!)!
        }
        
        pressedOperator = sender.currentTitle!
    }
    
    //button handler for "=" button
    @IBAction func equalPressed(_ sender: UIButton) {
        resultClickSound.play()
        
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
        
        userStartTyping = false
    }
    
    //function is cutting "0" for decimal result
    func forTailingZero(temp: Float) -> String {
        let tempVar = String(format: "%g", temp)
        return tempVar
    }
    
    //error handler which reset all operations if error is appeared on the screen
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
    
    //reset all flags and operations to start postion
    func reset() {
        firstOperand = 0
        secondOperand = 0
        userStartTyping = false
        equalWasPressed = false
        pressedOperator = ""
    }

}

