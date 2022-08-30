//
//  StorageManager.swift
//  heLLo converter
//
//  Created by Мария Изюменко on 22.08.2022.
//

import RealmSwift
import Foundation

class StorageManager {
    
    static let shared = StorageManager()
    
    private var realm: Realm?
    
    init() {
        realm = try? Realm()
    }
    
    func saveCurrencies(currencies: [CurrencyModelDBO]) {
        do {
            try realm?.write {
                realm?.add(currencies, update: .modified)
            }
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func deleteCurrency(currency: CurrencyModelDBO) {
        do {
            try realm?.write {
                let predicate = NSPredicate(format: "id == %@", currency.id)
                if let object = realm?.objects(CurrencyModelDBO.self).filter(predicate).first {
                    realm?.delete(object)
                }
            }
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func getCurrencies() -> [CurrencyModelDBO]? {
        var currencies: [CurrencyModelDBO]?
        do {
            try realm?.write {
                if let objects = realm?.objects(CurrencyModelDBO.self) {
                    currencies = Array(objects)
                }
            }
        } catch let error {
            print(error.localizedDescription)
        }
        
        return currencies
    }
    
    func updateCurrency(currency: CurrencyModelDBO) {
        do {
            try realm?.write {
                realm?.add(currency, update: .modified)
            }
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func getFavouriteCurrencies() -> [CurrencyModelDBO]? {
        var currencies: [CurrencyModelDBO]?
        do {
            try realm?.write {
                let predicate = NSPredicate(format: "isFavourite == %d", true)
                if let objects = realm?.objects(CurrencyModelDBO.self).filter(predicate) {
                    currencies = Array(objects)
                }
            }
        } catch let error {
            print(error.localizedDescription)
        }
        return currencies
    }
}
