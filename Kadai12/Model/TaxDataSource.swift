//
//  TaxDataSource.swift
//  Kadai12
//
//  Created by 今村京平 on 2021/05/26.
//

import Foundation

protocol TaxDataSourceDelegate: class {
    func didsave(data: Int)
}

class TaxDataSource: NSObject {
    
    private let taxCalc = "TaxCalc"
    weak var delegate: TaxDataSourceDelegate?

    func loadData(didlode: @escaping (Int) -> Void) {
        let userDefaults = UserDefaults.standard
        let taxRate = userDefaults.integer(forKey: taxCalc)
        didlode(taxRate)
    }
    
    func save(taxRate: Int) {
        let userDefaults = UserDefaults.standard
        userDefaults.setValue(taxRate, forKey: taxCalc)
        delegate?.didsave(data: taxRate)
    }
}
