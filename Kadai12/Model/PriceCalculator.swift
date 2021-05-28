//
//  PriceCalculator.swift
//  Kadai12
//
//  Created by akio0911 on 2021/05/28.
//

import Foundation

struct PriceCalculator {
    /// 税込価格を計算する
    /// - Parameters:
    ///   - priceWithoutTax: 税抜価格
    ///   - taxRatePercentage: 消費税率。例えば8%の場合、0.08を渡す。
    /// - Returns: 税込価格
    func calculatePriceWithTax(priceWithoutTax: Int, taxRate: Double) -> Int {
        priceWithoutTax + Int(Double(priceWithoutTax) * taxRate)
    }
}
