//
//  CalculatorLogic.swift
//  Calculator
//
//  Created by Lucas Almeida on 04/03/19.
//  Copyright © 2019 Lucas Almeida on. All rights reserved.
//

import Foundation

struct CalculatorLogic {
    private var isFinishedTypingNumber: Bool = true
    
    private var intermidiateCalculation: (firstNumber: Double, calcMethod: String)?
    
    private var number: Double?
    
    mutating func setNumber(_ number: Double) {
        self.number = number
    }
    
    mutating func calculate(symbol: String) -> Double? {
        
        if let unwrappedNumber = number {
            switch symbol {
                case Operators.ac.rawValue:
                    return 0
                
                case Operators.plusOrMinus.rawValue:
                    isFinishedTypingNumber = false
                    let newValueWithoutZeroes = (unwrappedNumber * -1).removeZerosFromEnd()
                    number = Double(newValueWithoutZeroes)!
                    return number
                
                case Operators.percentage.rawValue:
                    return unwrappedNumber * 0.01
                
                case Operators.equals.rawValue:
                    return performTwoNumCalculator(secondNumber: unwrappedNumber)
                
                case Operators.add.rawValue,
                     Operators.sub.rawValue,
                     Operators.div.rawValue,
                     Operators.mult.rawValue:
                    intermidiateCalculation = (firstNumber: unwrappedNumber, calcMethod: symbol)
                
                default: 
                    fatalError("Invalid symbol")
            }
        }
        
        return nil
    }
    
    private func performTwoNumCalculator(secondNumber: Double) -> Double? {
        if let firstNumber = intermidiateCalculation?.firstNumber,
            let operation = intermidiateCalculation?.calcMethod {
            
            switch operation {
                case Operators.add.rawValue:
                    return firstNumber + secondNumber
                case Operators.sub.rawValue:
                    return firstNumber - secondNumber
                case Operators.div.rawValue:
                    if secondNumber != 0 {
                        return firstNumber
                    } else {
                        return nil
                    }
                case Operators.mult.rawValue:
                    return firstNumber * secondNumber
                default:
                    fatalError("Operation passed in does not match any case")
            }
        } else {
            return nil
        }
    }
}

extension Double {
    func removeZerosFromEnd() -> String {
        let formatter = NumberFormatter()
        let number = NSNumber(value: self)
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 16 //maximum digits in Double after dot (maximum precision)
        return String(formatter.string(from: number) ?? "")
    }
}
