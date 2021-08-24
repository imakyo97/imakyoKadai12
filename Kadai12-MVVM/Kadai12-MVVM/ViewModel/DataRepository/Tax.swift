//
//  Tax.swift
//  Kadai12-MVVM
//
//  Created by 今村京平 on 2021/08/23.
//

import Foundation
import RealmSwift

final class Tax: Object {
    @objc dynamic var rate: Int32 = 0

    convenience init(rate: Int32) {
        self.init()
        self.rate = rate
    }
}
