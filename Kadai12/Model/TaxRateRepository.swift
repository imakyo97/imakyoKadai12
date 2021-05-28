//
//  TaxRateRepository.swift
//  Kadai12
//
//  Created by 今村京平 on 2021/05/26.
//

import Foundation

// プロトコル継承に「class」キーワードを使用することは非推奨です。代わりに「AnyObject」を使用してください
protocol TaxRateRepositoryDelegate: AnyObject {
    func didSave(data: Int)
}

class TaxRateRepository {
    
    private let taxCalcKey = "TaxCalc"
    weak var delegate: TaxRateRepositoryDelegate?
    
    func loadData(didlode: @escaping (Int) -> Void) {
        let userDefaults = UserDefaults.standard
        let taxRate = userDefaults.integer(forKey: taxCalcKey)
        didlode(taxRate)
    }
    
    func save(taxRate: Int) {
        let userDefaults = UserDefaults.standard
        userDefaults.setValue(taxRate, forKey: taxCalcKey)
        delegate?.didSave(data: taxRate)
    }
}
