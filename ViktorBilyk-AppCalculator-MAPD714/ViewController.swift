//
//  Assigment 1 Calculator App
//  Version: 0.9 Advaced Calculations, refactoring
//
//  Created by Viktor Bilyk on 2017-09-26.
//  Copyright © 2017 Shifty Land LLC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Calculator variables
    var firstOperand:Double = 0 // left side of calculations
    var secondOperand:Double = 0 // right side of calcultions
    var onScreenNumber:Double = 0 //number on screen
    var calcResult:Double = 0 // result of calculations
    var isMath:Bool = false // is Math operation pressed
    var currentMathOperation:Int = 0 // selected ID of operation
    var isDot:Bool = false //is Dot pressed
    var isEqual:Bool = false //is equals pressed
    
    //Label outlet
    @IBOutlet weak var calcResultLabel: UILabel! //displays calcResult on UI
    
    //function to do basic calculations
    func calculations (operandA:Double, operandB:Double) -> Double {
        var tempResult:Double = 0
        switch currentMathOperation {
        case 11:
            tempResult = operandA + operandB
        case 12:
            tempResult = operandA - operandB
        case 13:
            tempResult = operandA * operandB
        case 14:
            tempResult = operandA / operandB
        case 15:
            tempResult = pow(operandA, 2)
        case 16:
            tempResult = sqrt(operandA)
        default: break
        }
        return tempResult
    }

    //NumPad press handler
    @IBAction func numPadButtonPress(_ sender: UIButton) {
        
        if isMath { //check if operation button pressed inorder to start recording new variable
            calcResultLabel.text = String(sender.tag-1)
            
        }
        else {
            //check if in process of inputting number
            if calcResultLabel.text == "0" {
                calcResultLabel.text = String(sender.tag-1)
            }
            else {
                calcResultLabel.text = calcResultLabel.text! + String(sender.tag-1)
            }
        }
        onScreenNumber = Double(calcResultLabel.text!)!
    }
    
    //Operations button handler
    @IBAction func operationsButtonClick(_ sender: UIButton) {
        //
        if isMath { //are we in process of calculation chain
            switch sender.tag {
            case 11, 12, 13, 14: //Adding, Multiplications, Division, Minus operations
                if !isEqual {// if equals not pressed continue chain otherwise restar calculations chain and wait for 2nd number
                    secondOperand = onScreenNumber
                    calcResult = calculations(operandA: firstOperand, operandB: secondOperand)
                    firstOperand = calcResult
                    currentMathOperation = sender.tag
                    calcResultLabel.text = String(calcResult)
                    isDot = false
                }
                else {
                    firstOperand = Double(calcResultLabel.text!)!
                    currentMathOperation = sender.tag
                    isDot = false
                }
            case 15, 16: //Square root and power to two operations
                if !isEqual {//if equals not pressed continue chain otherwise calculate and show result
                    secondOperand = onScreenNumber
                    calcResult = calculations(operandA: firstOperand, operandB: secondOperand)
                    firstOperand = calcResult
                    currentMathOperation = sender.tag
                    calcResultLabel.text = String(calcResult)
                    isDot = false
                }
                else {
                    firstOperand = Double(calcResultLabel.text!)!
                    currentMathOperation = sender.tag
                    calcResult = calculations(operandA: firstOperand, operandB: secondOperand)
                    firstOperand = calcResult
                    calcResultLabel.text = String(calcResult)
                    isDot = false
                }
            default:
                calcResultLabel.text = "Error"
            }
        }
        else {
            firstOperand = Double(calcResultLabel.text!)!
            currentMathOperation = sender.tag
            isDot = false
            isMath = true
        }
    }
    
    //PlusMinus operation
    @IBAction func plusMinusSwitch(_ sender: UIButton) {
    }
    
    //Dot button clicked
    @IBAction func dotPress(_ sender: UIButton) {
        
        if !isDot {// if dot is not pressed add dot otherwise do nothing
            calcResultLabel.text = calcResultLabel.text! + "."
            isDot = true
        }
    }
    
    //Equals button pressed
    @IBAction func equalsPress(_ sender: UIButton) {
        if isMath { //check if there is calculations to be done
            calcResult = calculations(operandA: firstOperand, operandB: onScreenNumber)
            firstOperand = calcResult
            calcResultLabel.text = String(calcResult)
            isDot = false
            isEqual = true
        }
    }
    
    //All Clear button pressed
    @IBAction func clearAllCalculator(_ sender: UIButton) {
        
        calcResultLabel.text = "0" //reset text in UI
        
        //reset all flags
        isMath = false
        isDot = false
        isEqual = false
        
        //reset calculations
        calcResult = 0
        firstOperand = 0
        secondOperand = 0
        onScreenNumber = 0
        
        //reset state of calc
        currentMathOperation = 0
        
    }
    
    
}

