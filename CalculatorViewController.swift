//
//  CalculatorViewController.swift
//  Calculator View Controller class
//  Created by Jared Barrow on 9/13/18.
//  Copyright © 2018 Jared Barrow. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {
    //Object reference pointing to the resultDisplay UILabel object in the UI
    @IBOutlet var resultDisplay: UILabel!
    //Object reference pointing to the enteredExpressionDisplay UILabel object in the UI
    @IBOutlet var enteredExpressionDisplay: UILabel!
    
    /*
     -----------------------------
     MARK: - Display Alert Message
     -----------------------------
     */
    func showAlertMessage(messageHeader header: String, messageBody body: String) {
        
        /*
         Create a UIAlertController object; dress it up with title, message, and preferred style;
         and store its object reference into local constant alertController
         */
        let alertController = UIAlertController(title: header, message: body, preferredStyle: UIAlertController.Style.alert)
        
        // Create a UIAlertAction object and add it to the alert controller
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        // Present the alert controller
        present(alertController, animated: true, completion: nil)
    }
    //variable for holding two possible operands
    var operand_1:Float = 0
    var operand_2:Float = 0
    
    //varibale for checking which operand to build
    var firstOp:Bool = true
    var secOp:Bool = false
    
    //string for second operand
    var secString:String = ""
    //variable for checking if operands have been built, starts building final result
    var finalResult:Bool = false
 
    //variable for holding the operation of the expression
    var operation:Int = 0
    
    //variable for checking if decimal has been pressed
    var hasPressedDecimal:Bool = false
    
    //varible for checking if first digit in expression has been entered
    var firstDigitEntered:Bool = false
    
    //variable for checking if evaluation has occured
    var evaluated:Bool = false
    
    //method for when a digit is added to the expression
    func pressedDigit(tag: Int){
        enteredExpressionDisplay.text = enteredExpressionDisplay.text! + String(tag)
    }

    //method for when the operator button is pressed
    func pressedOperator(tag: Int){
        switch(tag){
        case 14:
                enteredExpressionDisplay.text = enteredExpressionDisplay.text! + " + "
        case 13:
            enteredExpressionDisplay.text = enteredExpressionDisplay.text! + " - "
        case 12:
            enteredExpressionDisplay.text = enteredExpressionDisplay.text! + " x "
        case 11:
            enteredExpressionDisplay.text = enteredExpressionDisplay.text! + " ÷ "
            
        default:
            break;
        }
    }
    
    //Method for when the user presses the equals button
    func pressedEquals(){
        enteredExpressionDisplay.text = enteredExpressionDisplay.text! + " = "
    }

    //Method for when a decimal is added to the expression
    func pressedDecimal(){
        if (hasPressedDecimal || !firstDigitEntered){
            showAlertMessage(messageHeader: "Unrecognized Input!",
                             messageBody: "Please enter number1 (÷ x - +) number2 and then tap =")
        }
        else {
            enteredExpressionDisplay.text = enteredExpressionDisplay.text! + "."
        }
        hasPressedDecimal = true
    }
    //method for pressing clear
    func restart(){
    //restart variables for final result
    operand_1 = 0
    operand_2 = 0
    firstOp = true
    secOp = false
    secString = ""
    operation  = 0
    finalResult = false
    hasPressedDecimal = false
    firstDigitEntered = false
    //restart displays to blank form
    enteredExpressionDisplay.text = ""
    resultDisplay.text = ""
    }
    
    
    //Method that is called each time a button is tapped
    //case-switch loop used to handle each button
    @IBAction func buttonTapped(_ sender: UIButton) {
        //if the clear button is pressed
        if sender.tag == 10{
           restart()
        }

        else {
        //start with first operand
        if firstOp{
            switch(sender.tag){
            case _ where(sender.tag <= 9):
                if evaluated{
                    //restart displays to blank form
                    enteredExpressionDisplay.text = ""
                    resultDisplay.text = ""
                    evaluated = false
                }
                pressedDigit(tag: sender.tag)
                firstDigitEntered = true
            case _ where (11 <= sender.tag && sender.tag <= 15):
                if !firstDigitEntered{
                    showAlertMessage(messageHeader: "Unrecognized Input!",
                                     messageBody: "Please enter number1 (÷ x - +) number2 and then tap =")
                }
                else
                {
                operand_1 = Float(enteredExpressionDisplay.text!)!
                pressedOperator(tag: sender.tag)
                operation = sender.tag
                secOp = true
                firstOp = false
                firstDigitEntered = false
                hasPressedDecimal = false
                }
            case 16:
                pressedDecimal()
                
            case 15:
                showAlertMessage(messageHeader: "Unrecognized Input!",
                                 messageBody: "Please enter number1 (÷ x - +) number2 and then tap =")
                
            default:
                break;
        }
        }
        
       //move on to second operand 2
       else if secOp{
            switch(sender.tag){
            case _ where(sender.tag <= 9):
                
                pressedDigit(tag: sender.tag)
                firstDigitEntered = true
                if hasPressedDecimal{
                    secString = secString + "."
                    
                }
                secString = secString + String(sender.tag)
            case 16:
                pressedDecimal()
            case 15:
                pressedEquals()
                finalResult = true
                
            case _ where (11 <= sender.tag && sender.tag <= 14 && operation != 0):
                showAlertMessage(messageHeader: "Unrecognized Input!",
                                     messageBody: "Please enter number1 (÷ x - +) number2 and then tap =swag")
                
                
                
                
            default:
                break;
                
            
        }
        //move on to final result
        if finalResult{
            var result:Float = 0
            operand_2 = Float(secString)!
            switch(operation){
            case 14:
                result = operand_1 + operand_2
                resultDisplay.text = String(format: "%.3f", result)
            case 13:
                result = operand_1 - operand_2
                resultDisplay.text = String(format: "%.3f", result)
            case 12:
                result = operand_1 * operand_2
                resultDisplay.text = String(format: "%.3f", result)
            case 11:
                result = operand_1 / operand_2
                resultDisplay.text = String(format: "%.3f", result)
                
            default:
            break;
            }
            //reset entire process after evaluation
            operand_1 = 0
            operand_2 = 0
            firstOp = true
            secOp = false
            secString = ""
            operation  = 0
            finalResult = false
            hasPressedDecimal = false
            evaluated = true
            firstDigitEntered = false
            
            
          
        }
        }
        
    
}

}
}
