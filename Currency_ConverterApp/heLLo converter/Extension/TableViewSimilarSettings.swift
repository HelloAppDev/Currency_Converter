//
//  TableViewSimilarSettings.swift
//  heLLo converter
//
//  Created by Мария Изюменко on 23.08.2022.
//

import UIKit

extension UITableView {
    
    func similarSettings() {
        self.allowsSelection = true
        self.showsVerticalScrollIndicator = false
        self.separatorStyle = .none
        self.contentInset.bottom = 10
        let bundle = Bundle(for: CurrencyTableViewCell.self)
        self.register(UINib(nibName: "CurrencyTableViewCell", bundle: bundle), forCellReuseIdentifier: CurrencyTableViewCell.identifier)
        self.rowHeight = 105
    }
}
