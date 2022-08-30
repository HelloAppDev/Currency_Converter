//
//  UIButton.swift
//  heLLo converter
//
//  Created by Мария Изюменко on 25.08.2022.
//

import UIKit

class HighlightedButton: UIButton {
    
    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? .lightGray : .white
        }
    }
}
