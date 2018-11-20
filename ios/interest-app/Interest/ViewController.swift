//
//  ViewController.swift
//  Interest
//
//  Created by Allann Jones on 07/10/18.
//  Copyright © 2018 Allann Jones. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var labelStatus: UILabel!
    @IBOutlet weak var textFieldAmount: UITextField!
    @IBOutlet weak var textFieldProfitRate: UITextField!
    @IBOutlet weak var textFieldInvestmentTime: UITextField!
    @IBOutlet weak var labelInvestmentReturn: UILabel!
    @IBOutlet weak var labelInvestmentProfit: UILabel!
    
    override func viewDidLoad() {
        print("viewDidLoad()")

        super.viewDidLoad()
        
        textFieldProfitRate.delegate = self
        
        let toolbar:UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 30))
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(ViewController.doneButtonAction))

        toolbar.setItems([flexSpace, doneButton], animated: false)
        
        toolbar.sizeToFit()
        
        self.textFieldAmount.inputAccessoryView = toolbar
        self.textFieldProfitRate.inputAccessoryView = toolbar
        self.textFieldInvestmentTime.inputAccessoryView = toolbar
    }

    @objc func doneButtonAction() {
        print("doneButtonAction()")

        self.view.endEditing(true)
    }

    @IBAction func buttonCalculateClick(_ sender: Any) {
        print("buttonCalculateClick()")

        let investmentAmount: Double? = Double(textFieldAmount.text ?? "")
        let investmentTime: Double? = Double(textFieldInvestmentTime.text ?? "")
        
        let profitRate = NumberFormatter().number(from: textFieldProfitRate.text ?? "")
        
        if (investmentAmount == nil) {
            labelStatus.text = "Inform the initial amount."

            textFieldAmount.becomeFirstResponder()

            return;
        }
        
        if (profitRate == nil) {
            labelStatus.text = "Inform the profit rate."
            
            textFieldProfitRate.becomeFirstResponder()

            return;
        }

        if (investmentTime == nil) {
            labelStatus.text = "Inform the period."

            textFieldInvestmentTime.becomeFirstResponder()

            return;
        }

        print("Investment amount: " + String(describing: investmentAmount))
        print("Profit rate: " + profitRate!.stringValue)
        print("Amount profit: " + String(describing: investmentTime))

        let investmentReturn = investmentAmount! * pow((1.0 + profitRate!.doubleValue), investmentTime!)

        labelInvestmentReturn.text = investmentReturn.description
        
        let amountProfit = investmentReturn - investmentAmount!;
        
        labelInvestmentProfit.text = String(amountProfit);
    }
    
    @IBAction func textFieldShouldReturn(_ textField: UITextField) -> Void {
        print("textFieldAmountDoneEditing()")
        
        textField.resignFirstResponder()
    }
}

