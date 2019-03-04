//
//  ViewController.swift
//  Calculator
//
//  Created by Lucas Almeida on 25/02/2019.
//  Copyright © 2019 Lucas Almeida. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var displayLabel: UILabel!
    
    private var isFinishedTypingNumber = true
    
    private var calculator = CalculatorLogic()
    
    private var displayValue: Double {
        get {
            guard let number = Double(displayLabel.text!) else {
                fatalError("Cannot convert displayLabel.text to a Double")
            }
            return number
        } 
        set {
            displayLabel.text = String(newValue)
        }
    }
    
    @IBAction func calcButtonPressed(_ sender: UIButton) {
        //What should happen when a non-number button is pressed
    
        isFinishedTypingNumber = true
        
        calculator.setNumber(displayValue)
        
        if let calcMethod = sender.currentTitle {
            if let result = calculator.calculate(symbol: calcMethod) {
                displayValue = result
            }
        }
    }

    @IBAction func numButtonPressed(_ sender: UIButton) {
        
        //What should happen when a number is entered into the keypad

        if let numValue = sender.currentTitle {
            if isFinishedTypingNumber {
                if let numberPressed = Double(numValue) {
                    if isCurrentDisplayValueEqualToZero(value: numberPressed) {
                        displayLabel.text = displayLabel.text! + numValue
                    }
                }
                displayLabel.text = numValue
                isFinishedTypingNumber = false
            } else {
                if numValue == Operators.point.rawValue {
                    let isInt = floor(displayValue) == displayValue
                    
                    if !isInt || isCurrentDisplayValueEqualToZero(value: displayValue) {
                        return
                    }
                }
                
                displayLabel.text = displayLabel.text! + numValue
            }
        }
    }
    
    func isCurrentDisplayValueEqualToZero(value: Double) -> Bool {
        return floor(value) == 0
    }
}


