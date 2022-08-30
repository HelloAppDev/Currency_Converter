//
//  DataLoaderViewController.swift
//  heLLo converter
//
//  Created by Мария Изюменко on 17.08.2022.
//

import UIKit
import RealmSwift

final class CurrencyListTableViewController: UITableViewController {
    
    weak var delegate: CurrencySelectionDelegate?
    
    private var currencies = [CurrencyModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSettings()
        getCurrenciesFromDB()
        fetchCurrenciesFromServer()
    }
    
    private func initialSettings() {
        self.title = "Валюты"
        tableView.similarSettings()
        
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        refreshControl?.beginRefreshing()
    }
    
    @objc func refresh(_ sender: AnyObject) {
        fetchCurrenciesFromServer()
    }
    
    private func getCurrenciesFromDB() {
        if let currencies = StorageManager.shared.getCurrencies() {
            self.currencies = currencies.map { $0.asBDM() }
            self.refreshControl?.endRefreshing()
            self.tableView.reloadData()
        }
    }
    
    private func fetchCurrenciesFromServer() {
        ParseManager.shared.fetchData { currencies in
            var updatedCurrencies = currencies
            
            if let favouriteCurrencies = StorageManager.shared.getCurrencies(),
               !favouriteCurrencies.isEmpty {
                for index in 0..<updatedCurrencies.count {
                    updatedCurrencies[index].isFavourite = favouriteCurrencies.contains(where: { $0.id == updatedCurrencies[index].id })
                }
            }
            self.currencies = currencies
            self.refreshControl?.endRefreshing()
            self.tableView.reloadData()
            StorageManager.shared.saveCurrencies(currencies: currencies.map { $0.asDBO() })
        }
    }
    
    private func favouriteAction(at indexPath: IndexPath) -> UIContextualAction {
        var object = currencies[indexPath.row]
        let action = UIContextualAction(style: .normal, title: "Favourite") { action, view, completion in
            object.isFavourite.toggle()
            StorageManager.shared.updateCurrency(currency: object.asDBO())
            self.currencies[indexPath.row] = object
            completion(true)
        }
        action.backgroundColor = object.isFavourite ? .systemGreen : .systemGray
        action.image = UIImage(systemName: "star")
        
        return action
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension CurrencyListTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CurrencyTableViewCell.identifier, for: indexPath) as? CurrencyTableViewCell else { fatalError() }
        
        let currency = currencies[indexPath.row]
        cell.update(with: currency)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        
        StorageManager.shared.deleteCurrency(currency: currencies[indexPath.row].asDBO())
        currencies.remove(at: indexPath.row)
        self.tableView.deleteRows(at: [indexPath], with: .fade)
        tableView.reloadRows(at: [indexPath], with: .fade)
    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let favouriteAction = favouriteAction(at: indexPath)
        return UISwipeActionsConfiguration(actions: [favouriteAction])
    }
    

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currency = currencies[indexPath.row]
        
        delegate?.setupCurrency(currency: currency)
        
        delegate?.deselectFlagsButton()
        self.navigationController?.popViewController(animated: true)
    }
}

