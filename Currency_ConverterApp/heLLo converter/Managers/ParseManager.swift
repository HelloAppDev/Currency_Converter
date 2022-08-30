//
//  APIManager.swift
//  heLLo converter
//
//  Created by Мария Изюменко on 29.08.2022.
// 8

import UIKit

final class ParseManager: NSObject {
    
    static let shared = ParseManager()
    
    private var currencies: [CurrencyModel] = []
    
    private var currentTag = ""
    private var id = ""
    private var charCode = ""
    private var name = ""
    private var value = ""
    private var nominal = ""
    
    override init() {
    }
    
    func fetchData(completion: @escaping ([CurrencyModel]) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            if let url = URL(string: "https://cbr.ru/scripts/XML_daily.asp"),
            let parser = XMLParser(contentsOf: url) {
                parser.delegate = self
                guard parser.parse() else { return }
                
                DispatchQueue.main.async {
                    completion(self.currencies)
                }
            }
        }
    }
}

extension ParseManager: XMLParserDelegate {
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        if elementName == "Valute" {
            id = attributeDict["ID"] ?? ""
            nominal = String()
            name = String()
            value = String()
            charCode = String()
        }
        self.currentTag = elementName
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "Valute" {
            let currency = CurrencyModel(id: id,
                                         charCode: charCode,
                                         name: name,
                                         value: value,
                                         nominal: nominal)
            currencies.append(currency)
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let data = string.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !data.isEmpty else { return }
        
        switch currentTag {
        case "Name":
            name += data
        case "Value":
            value += data
        case "CharCode":
            charCode += data
        case "Nominal":
            nominal += data
        default:
            break
        }
    }
}
