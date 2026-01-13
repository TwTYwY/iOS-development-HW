//
//  UIColor+Extensions.swift
//  aaignatovaPW2
//
//  Created by Anzhelika Ignatova on 13.01.2026.
//

import UIKit

extension UIColor {
    convenience init(hex: Int, alpha: CGFloat = WishMakerConstants.Color.fullAlpha) {
        let red = CGFloat((hex >> WishMakerConstants.Color.redShift) & WishMakerConstants.Color.twoFirstNum) / WishMakerConstants.Color.maxHex
        let green = CGFloat((hex >> WishMakerConstants.Color.greenShift) & WishMakerConstants.Color.twoFirstNum) / WishMakerConstants.Color.maxHex
        let blue = CGFloat(hex & WishMakerConstants.Color.twoFirstNum) / WishMakerConstants.Color.maxHex
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}
