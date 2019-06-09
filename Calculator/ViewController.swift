//
//  ViewController.swift
//  Calculator
//
//  Created by Victor Ruiz on 5/21/19.
//  Copyright © 2019 Victor Ruiz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var primaryLabel: UILabel!
    //TODO: add a secondaryLabel that displays operandA (and maybe the operator) when available
    @IBOutlet weak var equalButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var multiplicationButton: UIButton!
    @IBOutlet weak var divisionButton: UIButton!
    @IBOutlet weak var percentButton: UIButton!
    @IBOutlet weak var plusMinusButton: UIButton!
    @IBOutlet weak var ACButton: UIButton!
    @IBOutlet weak var decimalButton: UIButton!
    @IBOutlet weak var zeroButton: UIButton!
    @IBOutlet weak var oneButton: UIButton!
    @IBOutlet weak var twoButton: UIButton!
    @IBOutlet weak var threeButton: UIButton!
    @IBOutlet weak var fourButton: UIButton!
    @IBOutlet weak var fiveButton: UIButton!
    @IBOutlet weak var sixButton: UIButton!
    @IBOutlet weak var sevenButton: UIButton!
    @IBOutlet weak var eightButton: UIButton!
    @IBOutlet weak var nineButton: UIButton!
    
    //MARK: Global Vars
    var operatorSelected : Bool = false
    var operators : [Bool] = [false, false, false, false]
                        //   /      x       -      +
    var operandA : Float!
    var operandB : Float!
    var operandChooser : Bool = true
    //true if you're editing operandA, false if you're editing operandB
    
    var marker2 : Bool = false
    var buttons : [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttons = [equalButton, plusButton, minusButton, multiplicationButton, divisionButton, percentButton, plusMinusButton, ACButton, decimalButton, zeroButton, oneButton, twoButton, threeButton, fourButton, fiveButton, sixButton, sevenButton, eightButton, nineButton]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        for x in buttons {
            x.layer.cornerRadius = x.bounds.height / 2
        }
    }

    @IBAction func ACButtonPressed(_ sender: UIButton) {
        primaryLabel.text = "0"
        operatorSelected = false
        marker = false
        clearOperators()
        decimalUsed = false
        operandA = nil
        operandB = nil
        operandChooser = true
    }
    
    func clearOperators() {
        for i in 0...operators.count - 1 {
           operators[i] = false
        }
        divisionButton.backgroundColor = .orange
        divisionButton.setTitleColor(.white, for: .normal)
        multiplicationButton.backgroundColor = .orange
        multiplicationButton.setTitleColor(.white, for: .normal)
        minusButton.backgroundColor = .orange
        minusButton.setTitleColor(.white, for: .normal)
        plusButton.backgroundColor = .orange
        plusButton.setTitleColor(.white, for: .normal)
    }
    
    //MARK: Non-Operands
    @IBAction func plusMinusButton(_ sender: UIButton) {
        primaryLabel.text = "-" + primaryLabel.text!
    }
    @IBAction func percentButton(_ sender: UIButton) {
        var x = getOperand()
        x = x / 100
        displaySolution(solution: x)
        marker2 = true
    }
    @IBAction func divisionButton(_ sender: UIButton) {
        if readyForOperator() {
            operatorSelected(operatorID: 0)
        }
    }
    @IBAction func multiplicationButton(_ sender: UIButton) {
        if readyForOperator() {
            operatorSelected(operatorID: 1)
        }
    }
    @IBAction func minusButton(_ sender: UIButton) {
        if readyForOperator() {
            operatorSelected(operatorID: 2)
        }
    }
    @IBAction func plusButton(_ sender: UIButton) {
        if readyForOperator() {
            operatorSelected(operatorID: 3)
        }
    }
    func operatorSelected(operatorID: Int) {
        operatorSelected = true
        setOperator(index: operatorID)
        operandA = getOperand()
        operandChooser = false
        
        switch(operatorID) {
        case 0:
            divisionButton.backgroundColor = .white
            divisionButton.setTitleColor(.orange, for: .normal)
        case 1:
            multiplicationButton.backgroundColor = .white
            multiplicationButton.setTitleColor(.orange, for: .normal)
        case 2:
            minusButton.backgroundColor = .white
            minusButton.setTitleColor(.orange, for: .normal)
        case 3:
            plusButton.backgroundColor = .white
            plusButton.setTitleColor(.orange, for: .normal)
        default:
            let x : Int = 1
        }
    }
    
    func setOperator(index: Int) {
        for i in 0...operators.count - 1 {
            if i == index {
                operators[i] = true
            } else {
                operators[i] = false
            }
        }
    }
    @IBAction func equalButton(_ sender: UIButton) {
        //Interpret()
        operandB = getOperand()
        
        var operatorSelect : Int = -1
        //find which operator is true
        for i in 0...operators.count - 1 {
            if operators[i] == true {
                operatorSelect = i
            }
        }
        
        var solution : Float!
        
        switch operatorSelect {
        case 0:
            // for divide
            solution = Float(operandA! / operandB!)
        case 1:
            //for mult
            solution = Float(operandA! * operandB!)
        case 2:
            //for minus
            solution = Float(operandA! - operandB!)
        case 3:
            //for plus
            solution = Float(operandA! + operandB!)
        default:
            print("nothing")
        }
        
        clearOperators()
        displaySolution(solution: solution)
        
        operandA = solution
        operandB = nil
        operandChooser = false
        marker = false
        marker2 = true
    }
    
    func displaySolution(solution: Float) {
        let val = solution - floorf(solution)
        if val != 0 {
            primaryLabel.text = String(solution)
        } else {
            let truncVal = Int(solution)
            primaryLabel.text = String(truncVal)
        }
    }
    
    @IBAction func decimalButton(_ sender: UIButton) {
        //TODO: add logic to check for a dot before adding one
        addSymbol(symbol: ".")
    }
    
    //MARK: Operands
    @IBAction func zeroButton(_ sender: UIButton) {
        //TODO: add logic to remove leading zeros
        addSymbol(symbol: "0")
    }
    @IBAction func oneButton(_ sender: UIButton) {
        addSymbol(symbol: "1")
    }
    @IBAction func twoButton(_ sender: UIButton) {
        addSymbol(symbol: "2")
    }
    @IBAction func threeButton(_ sender: UIButton) {
        addSymbol(symbol: "3")
    }
    @IBAction func fourButton(_ sender: UIButton) {
        addSymbol(symbol: "4")
    }
    @IBAction func fiveButton(_ sender: UIButton) {
        addSymbol(symbol: "5")
    }
    @IBAction func sixButton(_ sender: UIButton) {
        addSymbol(symbol: "6")
    }
    @IBAction func sevenButton(_ sender: UIButton) {
        addSymbol(symbol: "7")
    }
    @IBAction func eightButton(_ sender: UIButton) {
        addSymbol(symbol: "8")
    }
    @IBAction func nineButton(_ sender: UIButton) {
        addSymbol(symbol: "9")
    }
    

    var inInitState : Bool = true
    
    var marker : Bool  = false
    var decimalUsed : Bool = false

    func addSymbol(symbol : String) {
        
        if marker2 {
            operandChooser = true
            marker2 = false
            primaryLabel.text = "0"
        }
        
        if operandChooser {
            if decimalUsed {
                if primaryLabel.text == "0" {
                    primaryLabel.text = symbol
                } else {
                    if symbol != "." {
                        primaryLabel.text = primaryLabel.text! + symbol
                    }
                }
            } else {
                if primaryLabel.text == "0" {
                    primaryLabel.text = symbol
                    if symbol == "." {
                        decimalUsed = true
                    }
                } else {
                    if symbol == "." {
                        decimalUsed = true
                    }
                    primaryLabel.text = primaryLabel.text! + symbol
                }
            }
        } else {
            if !marker {
                primaryLabel.text = symbol
                marker = true
            } else {
                primaryLabel.text = primaryLabel.text! + symbol
            }
        }
    }
    
    func getOperand() -> Float {
        return Float(primaryLabel.text!)!
    }
    
    func readyForOperator() -> Bool {
        return primaryLabel.text != "0"
    }
}



