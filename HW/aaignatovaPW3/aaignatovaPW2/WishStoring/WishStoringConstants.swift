//
//  WishStoringConstants.swift
//  aaignatovaPW2
//
//  Created by Anzhelika Ignatova on 13.01.2026.
//

import UIKit

enum WishStoringConstants {
    enum Table {
        static let cornerRadius: CGFloat = 15
        static let offset: UIEdgeInsets = .init(top: 100, left: 20, bottom: 20, right: 20)
        static let sectionsCount: Int = 2
        static let backgroundColor: UIColor = .red
    }
    
    enum View {
        static let backgroundColor: UIColor = .blue
    }
    
    enum WrittenWishCell {
        static let wrapColor: UIColor = .white
        static let wrapRadius: CGFloat = 16
        static let wrapOffsetV: CGFloat = 5
        static let wrapOffsetH: CGFloat = 10
        static let wishLabelOffset: CGFloat = 8
        static let wishLabelTextColor: UIColor = .black
        static let clearBackgroundColor: UIColor = .clear
    }
    
    enum AddWishCell {
        static let wrapColor: UIColor = .white
        static let wrapRadius: CGFloat = 16
        static let wrapOffsetV: CGFloat = 5
        static let wrapOffsetH: CGFloat = 10
        static let textViewColor: UIColor = .lightGray
        static let textViewRadius: CGFloat = 8
        static let textViewOffset: CGFloat = 8
        static let textViewFont: UIFont = .systemFont(ofSize: 16)
        static let textViewContainerSize: UIEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        static let buttonColor: UIColor = .white
        static let buttonTextColor: UIColor = .systemPink
        static let buttonH: CGFloat = 45
        static let buttonOffset: CGFloat = 8
        static let textViewHeight: CGFloat = 80
        static let placeholderTextColor: UIColor = .darkGray
        static let enteredTextColor: UIColor = .black
        static let clearBackgroundColor: UIColor = .clear
        static let selectionStyle: UITableViewCell.SelectionStyle = .none
    }
}
