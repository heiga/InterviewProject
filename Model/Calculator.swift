//
//  Calculator.swift
//  InterviewProject
//
//  Created by Phillip Hoang on 2018-12-19.
//  Copyright © 2018 IC Heart Technologies. All rights reserved.
//

import Foundation

class Calculator {
    enum CalculatorError: Error {
        case negativeInput(inputs: [Int])
    }
    
    static func Add(numbers: String) throws -> Int {
        if numbers.count == 0 {
            return 0
        }

        // default delimiter
        var delimiterArray = [","]
        
        // mutable input
        var inputString = numbers
        
        // check for custom delimiter
        if inputString.range(of: "//") != nil {
            delimiterArray = []
            // remove slashes from input
            inputString = numbers.replacingOccurrences(of: "//", with: "")
            
            // delimiter will be the characters before the first newline
            let delimiters = inputString.components(separatedBy: "\n")
            
            // separate delimiters if there are multiple
            delimiterArray = delimiters[0].components(separatedBy: ",")
            
            /*
            for char in inputString {
                if char != "\n" {
                    delimiter = delimiter + String(char)
                    print("char = \(char)")
                } else {
                    break
                }
            }
            */
        }
        
        // remove newline
        inputString = inputString.replacingOccurrences(of: "\n", with: "")
        // remove spaces
        inputString = inputString.replacingOccurrences(of: " ", with: "")
        
        // replace all delimiters with commas (the default delimiter)
        for delimiter in delimiterArray {
            inputString = inputString.replacingOccurrences(of: delimiter, with: ",")
        }

        var sum = 0
        var negativeNumbers = [Int]()
        
        // split the input on commas
        let numberArray = inputString.components(separatedBy: ",")
        
        // iterate through the inputs
        for number in numberArray {
            if let numberAsInt = Int(number) {
                if numberAsInt < 0 {
                    negativeNumbers.append(numberAsInt)
                } else if numberAsInt <= 1000 {
                    sum += numberAsInt
                }
            }
        }
        
        // if negatives found, throw exception that contains all the negatives
        if negativeNumbers.count > 0 {
            throw CalculatorError.negativeInput(inputs: negativeNumbers)
        }
        
        return sum
    }
    
    static func runAddTests() -> String {
        var displayString = ""
        
        let validString = "1,2,5"
        displayString = addInputOutputToString(string: displayString, input: validString)
        
        let zeroString = "0,0,0,0"
        displayString = addInputOutputToString(string: displayString, input: zeroString)
        
        let zeroMixedString = "1,0,0,9"
        displayString = addInputOutputToString(string: displayString, input: zeroMixedString)
        
        let customDelimitedString = "//$\n1$2$3"
        displayString = addInputOutputToString(string: displayString, input: customDelimitedString)
        
        let customLongDelimited = "//***\n1***4***5"
        displayString = addInputOutputToString(string: displayString, input: customLongDelimited)
        
        let thousandsOverflowInput = "2,1001,1000,2018,9999,99999"
        displayString = addInputOutputToString(string: displayString, input: thousandsOverflowInput)
        
        let legalThousandsInput = "1000, 1000, 1000"
        displayString = addInputOutputToString(string: displayString, input: legalThousandsInput)
        
        let multipleDelimiters = "//$,@\n1$2@3"
        displayString = addInputOutputToString(string: displayString, input: multipleDelimiters)
        
        let multipleLongDelimiters = "//!!!!!!!!,!@#,(((\n1!!!!!!!!2!@#9(((10!!!!!!!!8"
        displayString = addInputOutputToString(string: displayString, input: multipleLongDelimiters)
        
        let wordDelimiters = "//potato,tomato,iPhone\n1potato2tomato7iPhone6"
        displayString = addInputOutputToString(string: displayString, input: wordDelimiters)
        
        let negativeInputs = "1,2,3,-1,-2"
        displayString = addInputOutputToString(string: displayString, input: negativeInputs)
        
        let newLineInputs = "\n1,2\n,3\n"
        displayString = addInputOutputToString(string: displayString, input: newLineInputs)

        return displayString
    }
    
    static func addInputOutputToString(string: String, input: String) -> String {
        var returnString = string
        
        do {
            let output = try Add(numbers: input)
            returnString += """
            Input: \"\(input)\"
            Output: \(output)\n\n
            """
        } catch CalculatorError.negativeInput(let negatives) {
            returnString += """
            Input: \"\(input)\"
            Output: Negatives not allowed: \(negatives)\n\n
            """
        } catch {
            
        }
        
        return returnString
    }
}









