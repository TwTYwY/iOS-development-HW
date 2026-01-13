//
//  WishMakerConstants.swift
//  aaignatovaPW2
//
//  Created by Anzhelika Ignatova on 13.01.2026.
//

import UIKit

enum WishMakerConstants {
    enum Color {
        static let pinkColor = UIColor(hex: 0xFFB6C1)
        static let colorMin: CGFloat = 0
        static let colorMax: CGFloat = 1
        static let maxHex: CGFloat = 255.0
        static let twoFirstNum: Int = 0xFF
        static let redShift: Int = 16
        static let greenShift: Int = 8
        static let fullAlpha: CGFloat = 1.0
    }
    
    enum Layout {
        static let buttonHeight: CGFloat = 45
        static let buttonBottom: CGFloat = 40
        static let buttonSide: CGFloat = 20
        static let buttonRadius: CGFloat = 15
        static let titleFontSize: CGFloat = 32
        static let discriptionFontSize: CGFloat = 20
        static let titleLabelLeading: CGFloat = 20
        static let titleLabelTop: CGFloat = 30
        static let discriptionTop: CGFloat = 20
        static let sliderButtonTop: CGFloat = 20
        static let sliderButtonWidth: CGFloat = 200
        static let sliderButtonHeight: CGFloat = 30
        static let stackBottom: CGFloat = -15
        static let stackCornerRadius: CGFloat = 20
        static let buttonSpacing: CGFloat = 10
    }
    
    enum Slider {
        static let titleTop: CGFloat = 10
        static let titleLeading: CGFloat = 20
        static let sliderBottom: CGFloat = -10
    }
}
