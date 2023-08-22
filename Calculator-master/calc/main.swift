//
//  main.swift
//  calc
//
//  Created by Jesse Clark on 12/3/18.
//  Copyright © 2018 UTS. All rights reserved.
//

import Foundation
import MapKit

var args = ProcessInfo.processInfo.arguments
args.removeFirst() // remove the name of the program

var j = 0
var userInput: String = ""
while j < args.count {
    userInput+=args[j]
    j+=1
    
}

//Removes white spaces from code
let trimmedInput = userInput.replacingOccurrences(of: " ", with: "")


//The next 18 lines will divide the user's input into an array. Separators are in place to ensure the user's result is calculated correctly
let scanner = Scanner(string: trimmedInput)
let separators = CharacterSet(charactersIn: "+-x/%")


var valueArr: [String] = []

while !scanner.isAtEnd {
    var value: Int = 0
    if scanner.scanInt(&value) {
        valueArr.append("\(value)")
    }
    
    var op: NSString? = ""
    if scanner.scanCharacters(from: separators, into: &op) {
        valueArr.append(op! as String)
    }
}

//Ensures all functions are together
order()
divide()
multiply()
modulo()
addition()
subtract()


//This function will ensure that operators will not double up and interrupt the user's calculation
func order() {
    var i = 1
    while (i < valueArr.count) {
        if valueArr[i] == "--" || valueArr[i] == "+-" {
            var temp = Int(valueArr[i+1]) ?? 0
            temp = temp - (2 * temp)
            valueArr[i+1] = String(temp)
            let value = valueArr[i]
            let first = Array(value)[0]
            valueArr[i] = String(first)
        }
        if valueArr[i] == "++" || valueArr[i] == "-+" {
            var temp = Int(valueArr[i+1]) ?? 0
            if temp < 0 {
                temp = temp + (2 * temp)
            }
            valueArr[i+1] = String(temp)
            let value = valueArr[i]
            let first = Array(value)[0]
            valueArr[i] = String(first)
        }
        if valueArr[i] == "x-" || valueArr[i] == "/-" || valueArr[i] == "%-" {
            var temp = Int(valueArr[i+1]) ?? 0
            temp = temp - (2 * temp)
            valueArr[i+1] = String(temp)
            let value = valueArr[i]
            let first = Array(value)[0]
            valueArr[i] = String(first)
        }
        i+=1
    }
}

//this function allows users to divide values within their calculation
func divide(){
    var i = 1
    while (i < valueArr.count) {
        if valueArr[i] == "/" {
            let temp1 = Int(valueArr[i-1]) ?? 0
            let temp2 = Int(valueArr[i+1]) ?? 0
            let tempAns = temp1 / temp2
            valueArr[i-1] = String(tempAns)
            valueArr.remove(at: i+1)
            valueArr.remove(at: i)
        }
        if valueArr[i-1] == "/" {
            let temp1 = Int(valueArr[i-2]) ?? 0
            let temp2 = Int(valueArr[i]) ?? 0
            let tempAns = temp1 / temp2
            valueArr[i] = String(tempAns)
            valueArr.remove(at: i-2)
            i-=1
            valueArr.remove(at: i-1)
        }
        i+=1
    }
}

//this function allows users to multiply their values
func multiply(){
    var i = 1
    while (i < valueArr.count) {
        if valueArr[i] == "x" {
            let temp1 = Int(valueArr[i-1]) ?? 0
            let temp2 = Int(valueArr[i+1]) ?? 0
            let tempAns = temp1 * temp2
            valueArr[i-1] = String(tempAns)
            valueArr.remove(at: i+1)
            valueArr.remove(at: i)
        }
        if valueArr[i-1] == "x" {
            let temp1 = Int(valueArr[i-2]) ?? 0
            let temp2 = Int(valueArr[i]) ?? 0
            let tempAns = temp1 * temp2
            valueArr[i] = String(tempAns)
            valueArr.remove(at: i-2)
            i-=1
            valueArr.remove(at: i-1)
        }
        i+=1
    }
}


//This function will allow the user to use the modulo symbol in their calculations
func modulo(){
    var i = 1
    while (i < valueArr.count) {
        //This if statement will effectively apply the modulo symbol with the value at the current iteration of the loop and the following value
        if valueArr[i] == "%" {
            let temp1 = Int(valueArr[i-1]) ?? 0
            let temp2 = Int(valueArr[i+1]) ?? 0
            let tempAns = temp1 % temp2
            valueArr[i-1] = String(tempAns)
            valueArr.remove(at: i+1)
            valueArr.remove(at: i)
        }
        //The below if statement will guarantee that users have not progressed too far within the main loop and ensure that order is maintained throughout the calculation
        if valueArr[i-1] == "%" {
            let temp1 = Int(valueArr[i-2]) ?? 0
            let temp2 = Int(valueArr[i]) ?? 0
            let tempAns = temp1 - temp1 % temp2
            valueArr[i] = String(tempAns)
            valueArr.remove(at: i-2)
            valueArr.remove(at: i-1)
        }
        i+=1
    }
}

//This function will complete the addition step of the calculation
func addition(){
    var i = 1
    while (i < valueArr.count) {
        //This if statement ensures that users do not have 2 operators together
        if valueArr[i] == "+" && valueArr[i+1] == "+" {
            valueArr.remove(at: i+1)
            i+=1
        }
        if valueArr[i] == "+" {
            let temp1 = Int(valueArr[i-1]) ?? 0
            let temp2 = Int(valueArr[i+1]) ?? 0
            let tempAns = temp1 + temp2
            valueArr[i-1] = String(tempAns)
            valueArr.remove(at: i+1)
            valueArr.remove(at: i)
        }
        //The below if statement will guarantee that users have not progressed too far within the main loop and calculate correctly
        if valueArr[i-1] == "+" {
            let temp1 = Int(valueArr[i-2]) ?? 0
            let temp2 = Int(valueArr[i]) ?? 0
            let tempAns = temp1 + temp2
            valueArr[i] = String(tempAns)
            valueArr.remove(at: i-2)
            i-=1
            valueArr.remove(at: i-1)
        }
        i+=1
    }
}

//The below function allows users to finally subtract values within their calculation
func subtract(){
    var i = 1
    while (i < valueArr.count) {
        //This if statement will effectively subtract the next value from the value at the current iteration of the loop
        if valueArr[i] == "-" {
            let temp1 = Int(valueArr[i-1]) ?? 0
            let temp2 = Int(valueArr[i+1]) ?? 0
            let tempAns = temp1 - temp2
            valueArr[i-1] = String(tempAns)
            valueArr.remove(at: i+1)
            valueArr.remove(at: i)
        }
        //The below if statement will guarantee that users have not progressed too far within the main loop and calculate correctly
        if valueArr[i-1] == "-" {
            let temp1 = Int(valueArr[i-2]) ?? 0
            let temp2 = Int(valueArr[i]) ?? 0
            let tempAns = temp1 - temp2
            valueArr[i] = String(tempAns)
            valueArr.remove(at: i-2)
            i-=1
            valueArr.remove(at: i-1)
        }
        i+=1
    }
}


//The final value in the array is the users result and this will be printed to the terminal. The calculation is complete
let final = valueArr[0]
print(final)




// Retrieve User Input
//let no1 =

//let no1 = args[0]; // Sample Code Only! Update Required!
//let operator = args[1]; // Sample Code Only! Update Required!
//let no2 = args[2]; // Sample Code Only! Update Required!

//for var i = 1; i <

// Initialize a Calculator object
//let calculator = Calculator();
////
////// Calculate the result
//let result = calculator.result(trimmedInput);
//print(result)
