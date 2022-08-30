//
//  CurrencyModel.swift
//  heLLo converter
//
//  Created by Мария Изюменко on 30.08.2022.
//

import Foundation

struct CurrencyModel {
    
    var id: String
    var charCode: String
    var name: String
    var value: String
    var nominal: String
    var isFavourite: Bool = false
    
    func asDBO() -> CurrencyModelDBO {
        return CurrencyModelDBO(id: id,
                                charCode: charCode,
                                name: name,
                                value: value,
                                nominal: nominal,
                                isFavourite: isFavourite)
    }
}
