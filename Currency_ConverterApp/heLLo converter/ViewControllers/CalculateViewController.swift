//
//  CalculateViewController.swift
//  heLLo converter
//
//  Created by Мария Изюменко on 24.08.2022.
//

import UIKit

protocol CurrencySelectionDelegate: AnyObject {
    func setupCurrency(currency: CurrencyModel)
    func deselectFlagsButton()
}

final class CalculateViewController: UIViewController {
    
    @IBOutlet private weak var topCurrencyView: UIView!
    @IBOutlet private weak var topButton: UIButton!
    @IBOutlet private weak var topCharCodeLabel: UILabel!
    @IBOutlet private weak var topValueLabel: UILabel!
    @IBOutlet private weak var topFlagButton: UIButton!
    @IBOutlet private weak var topFlagImageView: UIImageView!
    
    @IBOutlet private weak var bottomCurrencyView: UIView!
    @IBOutlet private weak var bottomButton: UIButton!
    @IBOutlet private weak var bottomCharCodeLabel: UILabel!
    @IBOutlet private weak var bottomValueLabel: UILabel!
    @IBOutlet private weak var bottomFlagButton: UIButton!
    @IBOutlet private weak var bottomFlagImageView: UIImageView!
    
    private var topCurrencyNominal = ""
    private var topCurrencyCourse = ""
    private var bottomCurrencyNominal = ""
    private var bottomCurrencyCourse = ""
    
    private let currencyListTableViewController = CurrencyListTableViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSettings()
    }
    
    private func initialSettings() {
        self.title = "Калькулятор"
        currencyListTableViewController.delegate = self
        
        topValueLabel.isUserInteractionEnabled = false
        bottomValueLabel.isUserInteractionEnabled = false
    }
    
    // MARK: - IBActions
    
    @IBAction func currencyAction(_ sender: UIButton) {
        sender.isSelected.toggle()
        
        if sender.tag == 0 {
            bottomButton.isSelected = false
        } else {
            topButton.isSelected = false
        }
        
        topCurrencyView.backgroundColor = topButton.isSelected
                                        ? .tabBarItemLight
                                        : .systemBackground
        bottomCurrencyView.backgroundColor = bottomButton.isSelected
                                           ? .tabBarItemLight
                                           : .systemBackground
    }
    
    @IBAction func currencySelectionAction(_ sender: UIButton) {
        self.navigationController?.pushViewController(currencyListTableViewController, animated: true)
        
        sender.isSelected.toggle()
        if sender.tag == 0 {
            bottomFlagButton.isSelected = false
        } else {
            topFlagButton.isSelected = false
        }
    }
    
    @IBAction func numPadActions(_ sender: UIButton) {
        let topCurrencyValue = topCurrencyCourse.toDouble() / topCurrencyNominal.toDouble()
        let bottomCurrencyValue = bottomCurrencyCourse.toDouble() / bottomCurrencyNominal.toDouble()
        
        if topButton.isSelected,
           let topValue = topValueLabel.text {
            let newValue = topValue + String(sender.tag)
            topValueLabel.text = newValue
            
            let result = topCurrencyValue * newValue.toDouble() / bottomCurrencyValue
            bottomValueLabel.text = String(result).maxLength(length: 5)
            
        } else if bottomButton.isSelected,
                  let bottomValue = bottomValueLabel.text {
            let newValue = bottomValue + String(sender.tag)
            bottomValueLabel.text = newValue
            
            let result = bottomCurrencyValue * newValue.toDouble() / topCurrencyValue
            topValueLabel.text = String(result).maxLength(length: 5)
        }
    }
    
    @IBAction func deleteAction(_ sender: Any) {
        topValueLabel.text = ""
        bottomValueLabel.text = ""
    }
    
    @IBAction func pointAction(_ sender: Any) {
        if topButton.isSelected {
            if let topValue = topValueLabel.text,
               !topValue.contains(",") {
                topValueLabel.text = topValue + ","
            }
        } else if bottomButton.isSelected {
            if let bottomValue = bottomValueLabel.text,
               !bottomValue.contains(",") {
                bottomValueLabel.text = bottomValue + ","
            }
        }
    }
}

extension CalculateViewController: CurrencySelectionDelegate {
    
    func setupCurrency(currency: CurrencyModel) {
        if topFlagButton.isSelected {
            bottomFlagButton.isSelected = false
            topCurrencyCourse = currency.value
            topCharCodeLabel.text = currency.charCode
            topCurrencyNominal = currency.nominal
            topFlagImageView.image = UIImage(named: currency.charCode)
            if topCharCodeLabel.text != nil {
                topFlagButton.setTitle("", for: .normal)
                topFlagButton.borderWidth = 0
                topFlagButton.backgroundColor = .clear
            }
        } else if bottomFlagButton.isSelected {
            topFlagButton.isSelected = false
            bottomCurrencyCourse = currency.value
            bottomCharCodeLabel.text = currency.charCode
            bottomCurrencyNominal = currency.nominal
            bottomFlagImageView.image = UIImage(named: currency.charCode)
            if bottomCharCodeLabel.text != nil {
                bottomFlagButton.setTitle("", for: .normal)
                bottomFlagButton.borderWidth = 0
                bottomFlagButton.backgroundColor = .clear
            }
        }
    }
    
    func deselectFlagsButton() {
        topFlagButton.isSelected = false
        bottomFlagButton.isSelected = false
        topValueLabel.text = ""
        bottomValueLabel.text = ""
    }
}
