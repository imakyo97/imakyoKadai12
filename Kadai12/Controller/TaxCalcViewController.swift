//
//  TaxCalcViewController.swift
//  Kadai12
//
//  Created by 今村京平 on 2021/05/26.
//

import UIKit

class TaxCalcViewController: UIViewController, UITextFieldDelegate, TaxDataSourceDelegate {
    
    private var taxDataSource: TaxDataSource!
    @IBOutlet private weak var taxExcludedTextField: UITextField!
    @IBOutlet private weak var taxRateTextField: UITextField!
    @IBOutlet private weak var taxIncludedLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        taxRateTextField.delegate = self
        taxDataSource = TaxDataSource()
        taxDataSource.delegate = self
        taxDataSource.loadData {[weak self] in self?.taxRateTextField.text = String($0) }
    }
    
    @IBAction private func tapBtn(_ sender: Any) {
        guard let taxExcluded = Double(taxExcludedTextField.text!) else { return }
        guard let taxRate = Double(taxRateTextField.text!) else { return }
        let taxIncludedDouble = taxExcluded * (taxRate / 100 + 1)
        let taxIncludedInt = Int(round(taxIncludedDouble))
        taxIncludedLabel.text = "\(taxIncludedInt)円"
        view.endEditing(true)
    }
    
    @IBAction private func tapView(_ sender: Any) {
        view.endEditing(true)
    }
    
    // MARK: - UITextFieldDelegate
    func textFieldDidEndEditing(_ textField: UITextField){
        if textField == taxRateTextField {
            guard let taxRate = Int(textField.text!) else { return }
            taxDataSource.save(taxRate: taxRate)
        }
    }
    
    // MARK: - TaxDataSourceDelegate
    func didsave(data: Int) {
            print("UserDafalutsにTaxRate:\(data)が保存されました")
        }
}

