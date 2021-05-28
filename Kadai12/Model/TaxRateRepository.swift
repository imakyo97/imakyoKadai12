//
//  TaxRateRepository.swift
//  Kadai12
//
//  Created by 今村京平 on 2021/05/26.
//

import Foundation

// Using 'class' keyword for protocol inheritance is deprecated; use 'AnyObject' instead
protocol TaxRateRepositoryDelegate: AnyObject {
    func didSave(data: Int)
}

class TaxRateRepository {
    
    private let taxCalcKey = "TaxCalc"
    weak var delegate: TaxRateRepositoryDelegate?
    
    func loadData(didLoad: @escaping (Int) -> Void) {
        let userDefaults = UserDefaults.standard
        let taxRate = userDefaults.integer(forKey: taxCalcKey)
        didLoad(taxRate)
    }
    
    func save(taxRate: Int) {
        let userDefaults = UserDefaults.standard
        userDefaults.setValue(taxRate, forKey: taxCalcKey)
        delegate?.didSave(data: taxRate)
    }
}
