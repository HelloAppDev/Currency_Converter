//
//  StringExtension.swift
//  heLLo converter
//
//  Created by Мария Изюменко on 23.08.2022.
//

import UIKit

extension String {
    
   func maxLength(length: Int) -> String {
       var string = self
       let nsString = string as NSString
       if nsString.length >= length {
           string = nsString.substring(with:
               NSRange(
                location: 0,
                length: nsString.length > length ? length : nsString.length)
           )
       }
       return  string
   }
    
    func toDouble() -> Double {
           let nsString = self as NSString
           return nsString.doubleValue
       }
}
