//
//  ViewController.swift
//  Kadai12-Realm
//
//  Created by 今村京平 on 2021/07/19.
//

import UIKit

final class ViewController: UIViewController {

    @IBOutlet private weak var taxExcludedTextField: UITextField! // 税抜金額
    @IBOutlet private weak var taxRateTextField: UITextField! // 消費税率
    @IBOutlet weak var includingTaxLabel: UILabel! // 税込金額

    private let dataRepository = DataRepository()

    override func viewDidLoad() {
        super.viewDidLoad()
        dataRepository.load(taxRate: { [weak self] in
            self?.taxRateTextField.text = String($0)
        })
    }

    @IBAction private func tappedCalcBtn(_ sender: Any) {
        guard let taxExcluded = Double(taxExcludedTextField.text!) else { return }
        guard let taxRate = Double(taxRateTextField.text!) else { return }
        let includingTax = calcIncludingTax(taxExcluded: taxExcluded, taxRate: taxRate)
        includingTaxLabel.text = String(includingTax)
        dataRepository.save(taxRate: taxRate)
    }

    private func calcIncludingTax(taxExcluded: Double, taxRate: Double) -> Double {
        let includingTax = taxExcluded * (taxRate / 100 + 1)
        return includingTax
    }

    @IBAction func deleteData(_ sender: Any) {
        dataRepository.delete()
        print("データ削除完了")
    }
}


