//
//  Tax.swift
//  Kadai12-Realm
//
//  Created by 今村京平 on 2021/07/19.
//

import Foundation
import RealmSwift

class Tax: Object {
    @objc dynamic var taxRate: Double = 0

    convenience init(taxRate: Double) {
        self.init()
        self.taxRate = taxRate
    }
}
