//
//  FavouriteCurrencyViewController.swift
//  heLLo converter
//
//  Created by Мария Изюменко on 17.08.2022.
//

import UIKit
import RealmSwift

final class FavouriteCurrencyViewController: UITableViewController {
    
    private var favouriteObjects = [CurrencyModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inititalSettings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFavouriteCurrenciesFromDB()
    }
    
    private func inititalSettings() {
        self.title = "Избранное"
        tableView.similarSettings()
    }
    
    private func getFavouriteCurrenciesFromDB() {
        if let favouriteObjects = StorageManager.shared.getFavouriteCurrencies() {
            self.favouriteObjects = favouriteObjects.map { $0.asBDM() }
            tableView.reloadData()
        }
    }
}

extension FavouriteCurrencyViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favouriteObjects.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CurrencyTableViewCell.identifier, for: indexPath) as! CurrencyTableViewCell
        
        let currency = favouriteObjects[indexPath.row]
        cell.update(with: currency)
        return cell
    }
}
