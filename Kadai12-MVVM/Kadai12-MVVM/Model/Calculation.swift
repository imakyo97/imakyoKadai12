//
//  Calculation.swift
//  Kadai12-MVVM
//
//  Created by 今村京平 on 2021/08/23.
//

import Foundation
import RxSwift
import RxRelay

protocol CalculationModel {
    var result: Observable<Int32> { get }
    func calculation(taxExcluded: Int32, taxRate: Int32)
}

final class Calculation: CalculationModel {

    private let resultRelay = PublishRelay<Int32>()

    var result: Observable<Int32> {
        resultRelay.asObservable()
    }

    func calculation(taxExcluded: Int32, taxRate: Int32) {
        let resultDouble = Double(taxExcluded) * (Double(taxRate) / 100 + 1)
        let result = Int32(resultDouble)
        resultRelay.accept(result)
    }
}
