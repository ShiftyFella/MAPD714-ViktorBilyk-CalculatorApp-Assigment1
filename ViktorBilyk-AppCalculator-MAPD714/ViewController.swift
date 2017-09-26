//
//  Assigment 1 Calculator App
//
//  Author: Viktor Bilyk
//  Student ID: 300964200
//
//  Date: September 26, 2017
//
//  Version: 1.0.1 ,
//        {Last minute fixes}
//
//  Supported Device: Universal, any Ipad or Iphone with iOS ver. 10.3
//  Supported Orientations: Portrait and Landscape
//
//  Description: Calculator application that can do multiplication, division, plus, minus,
//                      square root and rising to power of 2 operations
//
//  Created by Viktor Bilyk on 2017-09-26.
//  Copyright © 2017 Shifty Land LLC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        calcResultLabel.text = "0"
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
    var isInput:Bool = false //checks if input number is in progress
    
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
        
        if !isInput { //check if operation button pressed inorder to start recording new variable
            calcResultLabel.text = String(sender.tag-1)
            isInput = true
            
        }
        else {
            calcResultLabel.text = calcResultLabel.text! + String(sender.tag-1)
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
                }
                else {
                    firstOperand = Double(calcResultLabel.text!)!
                    currentMathOperation = sender.tag
                }
            case 15, 16: //Square root and power to two operations
                if !isEqual {//if equals not pressed continue chain otherwise calculate and show result
                    secondOperand = onScreenNumber
                    calcResult = calculations(operandA: firstOperand, operandB: secondOperand)
                    firstOperand = calcResult
                    currentMathOperation = sender.tag
                    calcResultLabel.text = String(calcResult)
                }
                else {
                    firstOperand = Double(calcResultLabel.text!)!
                    currentMathOperation = sender.tag
                    calcResult = calculations(operandA: firstOperand, operandB: secondOperand)
                    firstOperand = calcResult
                    calcResultLabel.text = String(calcResult)
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
    isInput = false //set flag to start input new number
    isDot = false //reset dot flag for new number input
    }
    
    //PlusMinus operation
    @IBAction func plusMinusSwitch(_ sender: UIButton) {
        onScreenNumber = -Double(calcResultLabel.text!)!
        calcResultLabel.text = String(onScreenNumber)
    }
    
    //Dot button clicked
    @IBAction func dotPress(_ sender: UIButton) {
        
        if !isDot {// if dot is not pressed add dot otherwise do nothing
            //check if number is actually integer, if not don't add the dot           
            if (Double(calcResultLabel.text!)!).truncatingRemainder(dividingBy: 1) == 0 {
            calcResultLabel.text = calcResultLabel.text! + "."
                isDot = true }
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
            isInput = false
        }
    }
    
    //All Clear button pressed
    @IBAction func clearAllCalculator(_ sender: UIButton) {
        
        calcResultLabel.text = "0" //reset text in UI
        
        //reset all flags
        isMath = false
        isDot = false
        isEqual = false
        isInput = false
        
        //reset calculations
        calcResult = 0
        firstOperand = 0
        secondOperand = 0
        onScreenNumber = 0
        
        //reset state of calc
        currentMathOperation = 0
        
    }
    
    
}

