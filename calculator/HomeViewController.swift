//
//  HomeViewController.swift
//  calculator
//
//  Created by tecnico_uio on 21/10/20.
//  Copyright © 2020 tecnico_uio. All rights reserved.
//

import UIKit

final class HomeViewController: UIViewController {
    
    
    
    
    //MARK:- outlets
    // result
    @IBOutlet weak var resultLabel: UILabel!
    // numbers
    @IBOutlet weak var number0: UIButton!
    @IBOutlet weak var number1: UIButton!
    @IBOutlet weak var number2: UIButton!
    @IBOutlet weak var number3: UIButton!
    @IBOutlet weak var number4: UIButton!
    @IBOutlet weak var number5: UIButton!
    @IBOutlet weak var number6: UIButton!
    @IBOutlet weak var number7: UIButton!
    @IBOutlet weak var number8: UIButton!
    @IBOutlet weak var number9: UIButton!
    @IBOutlet weak var numberDecimal: UIButton!
    // operators
    @IBOutlet weak var oparatorAC: UIButton!
    @IBOutlet weak var operatorPlusMinus: UIButton!
    @IBOutlet weak var operatorsPercent: UIButton!
    @IBOutlet weak var operatorResult: UIButton!
    @IBOutlet weak var operatorAddition: UIButton!
    @IBOutlet weak var operatorSubstraction: UIButton!
    @IBOutlet weak var operatorMultiplication: UIButton!
    @IBOutlet weak var operatorDivision: UIButton!
    
    
    
    
    
    
    
    
    
    //MARK:- Variables
    private var total: Double = 0 //Total
    private var temp: Double = 0 //Valor por pantalla
    private var operating = false //Indicar si se ha seleccionado un operador
    private var decimal = false //Indicar si el valor decimal
    private var operation: OperationType = .none //
    
    //MARK:- Constants
    private let kDecimalSeparator = Locale.current.decimalSeparator!
    private let kMaxLength = 9
    
    private let kTotal = "total"
    
    //    private let kMaxValue: Double = 999999999
//    private let kMinValue: Double = 0.00000001
    
    private enum OperationType{
        case none, addition, substraction, multiplication, division, percent
    }
    
    
    
    
    //MARK:- Formateo de valores Auxiliares
    private let auxFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        let locale = Locale.current
        formatter.groupingSeparator = ""
        formatter.decimalSeparator = locale.decimalSeparator
        formatter.numberStyle = .decimal
        
        formatter.maximumIntegerDigits=100
        formatter.minimumFractionDigits=0
        formatter.maximumFractionDigits=100
        
        return formatter
    }()

    
    // Formateo de valores auxiliares totales
    private let auxTotalFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = ""
        formatter.decimalSeparator = ""
        formatter.numberStyle = .decimal
        formatter.maximumIntegerDigits = 100
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 100
        return formatter
    }()
    
    // Formateo de valores por pantalla por defecto
    private let printFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        let locale = Locale.current
        formatter.groupingSeparator = locale.groupingSeparator
        formatter.decimalSeparator = locale.decimalSeparator
        formatter.numberStyle = .decimal
        formatter.maximumIntegerDigits = 9
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 8
        return formatter
    }()
    
    // Formateo de valores por pantalla en formato científico
    private let printScientificFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .scientific
        formatter.maximumFractionDigits = 3
        formatter.exponentSymbol = "e"
        return formatter
    }()
    

    
    
    

    //Mark:- Initialization
    init() {
        super.init(nibName: nil,bundle:nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Redondeo de botones
        number0.round()
        number1.round()
        number2.round()
        number3.round()
        number4.round()
        number5.round()
        number6.round()
        number7.round()
        number8.round()
        number9.round()
        numberDecimal.round()
        oparatorAC.round()
        operatorPlusMinus.round()
        operatorsPercent.round()
        operatorResult.round()
        operatorAddition.round()
        operatorSubstraction.round()
        operatorMultiplication.round()
        operatorDivision.round()
        
        numberDecimal.setTitle(kDecimalSeparator, for: .normal)
        
        total = UserDefaults.standard.double(forKey: kTotal)
        
        result()
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        // Redondeo de botones
        number0.round()
        number1.round()
        number2.round()
        number3.round()
        number4.round()
        number5.round()
        number6.round()
        number7.round()
        number8.round()
        number9.round()
        numberDecimal.round()
        oparatorAC.round()
        operatorPlusMinus.round()
        operatorsPercent.round()
        operatorResult.round()
        operatorAddition.round()
        operatorSubstraction.round()
        operatorMultiplication.round()
        operatorDivision.round()
        
        
        
    }
    
    
    
    //Mark:- Button Actions
    @IBAction func operatorACacction(_ sender: UIButton) {
        clear()
        sender.shine()
    }
    @IBAction func operatorPlusMinusacction(_ sender: UIButton) {
        temp *= (-1)
        resultLabel.text = printFormatter.string(from: NSNumber(value: temp))
        sender.shine()
    }
    
    
    @IBAction func operatorsPercentAcction(_ sender: UIButton) {
        if operation != .percent{
            result()
        }
        operating = true
        operation = .percent
        result()
        sender.shine()
    }
    
    
    @IBAction func operatorResultAcction(_ sender: UIButton) {
        print("temp: \(temp)")
        print("total: \(total)")
        
        result()
        sender.shine()
    }
    
    @IBAction func operatorAditionAcction(_ sender: UIButton) {
        if operation != .none {
            result()
        }
        
        operating = true
        operation = .addition
        sender.selectOperation(true)
        
        sender.shine()
    }
    @IBAction func operatorSubstractorAcction(_ sender: UIButton) {
        if operation != .none {
            result()
        }
        
        operating = true
        operation = .substraction
        sender.selectOperation(true)
        
        sender.shine()
    }
    @IBAction func operatorMultiplicationAcction(_ sender: UIButton) {
        if operation != .none {
            result()
        }
        
        operating = true
        operation = .multiplication
        sender.selectOperation(true)
        
        sender.shine()
    }
    @IBAction func operatorDivisionAcction(_ sender: UIButton) {
        if operation != .none {
            result()
        }
        
        operating = true
        operation = .division
        sender.selectOperation(true)
        
        sender.shine()
    }
    
    
    
    
    
    @IBAction func numberDecimalAcction(_ sender: UIButton) {

        let currentTemp = auxTotalFormatter.string(from: NSNumber(value: temp))!
        if resultLabel.text?.contains(kDecimalSeparator) ?? false || (!operating && currentTemp.characters.count >= kMaxLength) {
            return
        }
        
        resultLabel.text = resultLabel.text! + kDecimalSeparator
        decimal = true
        
        selectVisualOperation()
        
        sender.shine()
    }
    
    
    
    
    
    
    
    @IBAction func numberAction(_ sender: UIButton) {
        
        oparatorAC.setTitle("C", for: .normal)
        
        var currentTemp = auxTotalFormatter.string(from: NSNumber(value: temp))!
        if !operating && currentTemp.characters.count >= kMaxLength {
            return
        }
        
        currentTemp = auxFormatter.string(from: NSNumber(value: temp))!
        
        
        // Hemos seleccionado una operación
        if operating {
            total = total == 0 ? temp : total
            resultLabel.text = ""
            currentTemp = ""
            operating = false
        }
        
        // Hemos seleccionado decimales
        if decimal {
            currentTemp = "\(currentTemp)\(kDecimalSeparator)"
            decimal = false
        }
        
        
        let number = sender.tag
        temp = Double(currentTemp + String(number))!
        resultLabel.text = printFormatter.string(from: NSNumber(value: temp))
        
        selectVisualOperation()
        
        sender.shine()
        print(sender.tag)
    }
    

    
    
    //Fun Limpia los valores
    private func clear(){
//        print(temp)
//        operation = .none
//        oparatorAC.setTitle("AC", for: .normal)
//        if temp != 0 {
//            temp = 0
//            resultLabel.text = "0"
//        } else {
//            total = 0
//            result()
//        }
        
        if operation == .none {
            total = 0
        }
        operation = .none
        oparatorAC.setTitle("AC", for: .normal)
        if temp != 0 {
            temp = 0
            resultLabel.text = "0"
        } else {
            total = 0
            result()
        }
        print(temp)
    }
    
    
    
    
    
    
    
    
    //Func obtiene el resultado final
    private func result(){
        switch operation {
        case .none:
            // no se hace nada
            break
        case .addition:
            total = total + temp
            break
        case .substraction:
            total = total - temp
            break
        case .multiplication:
            total = total * temp
            break
        case .division:
            total = total / temp
            break
        case .percent:
            temp = temp / 100
            total = temp
            break
        }
       
        // Formateo en pantalla
        if let currentTotal = auxTotalFormatter.string(from: NSNumber(value: total)), currentTotal.characters.count > kMaxLength {
            resultLabel.text = printScientificFormatter.string(from: NSNumber(value: total))
        } else {
            resultLabel.text = printFormatter.string(from: NSNumber(value: total))
        }
        
        operation = .none
        
        selectVisualOperation()
        
        UserDefaults.standard.set(total, forKey: kTotal)
        
        print("TOTAL: \(total)")
        
    }
    
    // Muestra de forma visual la operación seleccionada
    private func selectVisualOperation() {
        
        if !operating {
            // No estamos operando

            
            operatorAddition.selectOperation(false)
            operatorSubstraction.selectOperation(false)
            operatorMultiplication.selectOperation(false)
            operatorDivision.selectOperation(false)
        } else {
            switch operation {
            case .none, .percent:
                operatorAddition.selectOperation(false)
                operatorSubstraction.selectOperation(false)
                operatorMultiplication.selectOperation(false)
                operatorDivision.selectOperation(false)
                break
            case .addition:
                operatorAddition.selectOperation(true)
                operatorSubstraction.selectOperation(false)
                operatorMultiplication.selectOperation(false)
                operatorDivision.selectOperation(false)
                break
            case .substraction:
                operatorAddition.selectOperation(false)
                operatorSubstraction.selectOperation(true)
                operatorMultiplication.selectOperation(false)
                operatorDivision.selectOperation(false)
                break
            case .multiplication:
                operatorAddition.selectOperation(false)
                operatorSubstraction.selectOperation(false)
                operatorMultiplication.selectOperation(true)
                operatorDivision.selectOperation(false)
                break
            case .division:
                operatorAddition.selectOperation(false)
                operatorSubstraction.selectOperation(false)
                operatorMultiplication.selectOperation(false)
                operatorDivision.selectOperation(true)
                break
            }
        }
    
    
    
}
}
