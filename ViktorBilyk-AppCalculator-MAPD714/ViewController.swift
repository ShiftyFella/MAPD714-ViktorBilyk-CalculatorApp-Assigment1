//
//  Assigment 1 Calculator App
//  Version: 0.7 NumPad, dot, AC logic created
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
    var calcResult:Double = 0 // result of calculations
    var isMath:Bool = false // is Math operation pressed
    var currentMathOperation:Int = 0 // selected ID of operation
    var isDot:Bool = false //is Dot pressed
    
    //Label outlet
    @IBOutlet weak var calcResultLabel: UILabel! //displays calcResult on UI
    
    //function to do basic calculations
    func calculations () -> Double {
        var tempResult:Double = 0
        switch currentMathOperation {
        case 11:
            tempResult = firstOperand + secondOperand
        case 12:
            tempResult = firstOperand - secondOperand
        case 13:
            tempResult = firstOperand * secondOperand
        case 14:
            tempResult = firstOperand / secondOperand
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
    }
    
    //Operations button handler
    @IBAction func operationsButtonClick(_ sender: UIButton) {
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
    }
    
    //All Clear button pressed
    @IBAction func clearAllCalculator(_ sender: UIButton) {
        
        calcResultLabel.text = "0" //reset text in UI
        
        //reset all flags
        isMath = false
        isDot = false
        
        //reset calculations
        calcResult = 0
        firstOperand = 0
        secondOperand = 0
        
        //reset state of calc
        currentMathOperation = 0
        
    }
    
    
}

