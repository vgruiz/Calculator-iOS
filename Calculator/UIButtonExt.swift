//
//  UIButtonExt.swift
//  Calculator
//
//  Created by Victor Ruiz on 6/4/19.
//  Copyright © 2019 Victor Ruiz. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    func setColors(defaultColor: UIColor, highlightColor: UIColor) {
        override open var isHighlighted: Bool {
            didSet {
                backgroundColor = isHighlighted ? defaultColor : highlightColor
            }
        }
    }
    
}
