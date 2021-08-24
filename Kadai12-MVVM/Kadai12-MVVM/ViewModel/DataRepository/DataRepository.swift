//
//  DataRepository.swift
//  Kadai12-MVVM
//
//  Created by 今村京平 on 2021/08/24.
//

import Foundation
import RealmSwift

struct DataRepository {

    private let realm = try! Realm()

    init() {
        try! realm.write {
            realm.add(Tax(rate: 0))
        }
    }

    func save(taxRate: Int32) {
        print("\(taxRate) : \(#function)")
        try! realm.write {
            realm.objects(Tax.self).first?.setValue(taxRate, forKey: "rate")
        }
    }

    func load() -> Int32? {
        guard let taxRate = realm.objects(Tax.self).first?.rate else { return nil }
        print("\(taxRate)\(#function)")
        return taxRate
    }

    func delete() {
        try! realm.write {
            realm.deleteAll()
        }
    }
}
