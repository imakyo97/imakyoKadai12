//
//  DataRepository.swift
//  Kadai12-Realm
//
//  Created by 今村京平 on 2021/07/19.
//

import Foundation
import RealmSwift

struct DataRepository {

    private let realm = try! Realm()

    init() {
        try! realm.write {
            realm.add(Tax(taxRate: 0))
        }
    }

    func save(taxRate: Double) {
        let tax = realm.objects(Tax.self)
        try! realm.write {
            tax.setValue(taxRate, forKey: "taxRate")
        }
    }

    func load(taxRate: @escaping (Double) -> Void) {
        let tax = realm.objects(Tax.self)
        guard let loadTaxRate = tax.first?.taxRate else { return }
        taxRate(loadTaxRate)
    }

    func delete() {
        try! realm.write {
            realm.deleteAll()
        }
    }
}
