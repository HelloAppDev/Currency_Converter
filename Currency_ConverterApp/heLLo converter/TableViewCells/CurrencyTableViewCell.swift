//
//  CurrencyTableViewCell.swift
//  heLLo converter
//
//  Created by Мария Изюменко on 20.08.2022.
//

import UIKit

class CurrencyTableViewCell: UITableViewCell {

    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var charCodeLabel: UILabel!
    @IBOutlet private weak var valueLabel: UILabel!
    @IBOutlet private weak var nominalLabel: UILabel!
    
    static let identifier = "cell"
    
    func update(with currency: CurrencyModel) {
        nameLabel?.text = currency.name
        charCodeLabel?.text = currency.charCode
        valueLabel?.text = currency.value.maxLength(length: 5)
        nominalLabel?.text = currency.nominal
    }
}
