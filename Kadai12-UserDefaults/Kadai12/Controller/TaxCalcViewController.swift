//
//  TaxCalcViewController.swift
//  Kadai12
//
//  Created by 今村京平 on 2021/05/26.
//

import UIKit

class TaxCalcViewController: UIViewController, UITextFieldDelegate, TaxRateRepositoryDelegate {
    
    private let taxRateRepository = TaxRateRepository()
    private let priceCalculator = PriceCaluculator()
    
    @IBOutlet private weak var taxExcludedTextField: UITextField!
    @IBOutlet private weak var taxRateTextField: UITextField!
    @IBOutlet private weak var taxIncludedLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        taxRateTextField.delegate = self
        taxRateRepository.delegate = self
        
        taxRateRepository.loadData {[weak self] in self?.taxRateTextField.text = String($0) }
    }
    
    @IBAction private func tapBtn(_ sender: Any) {
        guard let taxExcluded = Int(taxExcludedTextField.text!) else { return }
        guard let taxRate = Double(taxRateTextField.text!) else { return }
        let  priceWithTax = priceCalculator.calculatePriceWithTax(
            priceWithoutTax: taxExcluded,
            taxRate: taxRate / 100.0
        )
        
        taxIncludedLabel.text = "\(priceWithTax)円"
        view.endEditing(true)
    }
    
    @IBAction private func tapView(_ sender: Any) {
        view.endEditing(true)
    }
    
    // MARK: - UITextFieldDelegate
    func textFieldDidEndEditing(_ textField: UITextField){
        if textField == taxRateTextField {
            guard let taxRate = Int(textField.text!) else { return }
            taxRateRepository.save(taxRate: taxRate)
        }
    }
    
    // MARK: - TaxRateRepositoryDelegate
    func didSave(data: Int) {
        print("UserDafalutsにTaxRate:\(data)が保存されました")
    }
}

