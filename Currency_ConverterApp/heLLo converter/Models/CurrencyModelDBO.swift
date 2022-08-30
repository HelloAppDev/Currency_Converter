//
//  CurrencyModel.swift
//  heLLo converter
//
//  Created by Мария Изюменко on 18.08.2022.
//

import Foundation
import RealmSwift

class CurrencyModelDBO: Object {
    
    @objc dynamic var id: String = ""
    @objc dynamic var charCode: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var value: String = ""
    @objc dynamic var nominal: String = ""
    @objc dynamic var isFavourite: Bool = false
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(id: String,
                     charCode: String,
                     name: String,
                     value: String,
                     nominal: String,
                     isFavourite: Bool) {
        self.init()
        self.id = id
        self.charCode = charCode
        self.name = name
        self.value = value
        self.nominal = nominal
        self.isFavourite = isFavourite
    }
    
    func asBDM() -> CurrencyModel {
        return CurrencyModel(id: id,
                             charCode: charCode,
                             name: name,
                             value: value,
                             nominal: nominal,
                             isFavourite: isFavourite)
    }
}
