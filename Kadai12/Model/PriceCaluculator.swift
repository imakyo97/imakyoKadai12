//
//  PriceCaluculator.swift
//  Kadai12
//
//  Created by 今村京平 on 2021/05/28.
//

import Foundation

struct PriceCaluculator {
    
    func calculatePriceWithTax(priceWithoutTax: Int, taxRate: Double) -> Int {
        priceWithoutTax + Int(Double(priceWithoutTax) * taxRate)
    }
}
