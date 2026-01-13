//
//  WishCalendarConstants.swift
//  aaignatovaPW2
//
//  Created by Anzhelika Ignatova on 13.01.2026.
//
import UIKit

enum WishCalendarConstants {
    enum CollectionView {
        static let collectionTop: CGFloat = 0
        static let insets = UIEdgeInsets(top: 20, left: 16, bottom: 20, right: 16)
    }
    
    enum EventCell {
        // Layout
        static let offset: CGFloat = 8
        static let cornerRadius: CGFloat = 12
        static let iconSize: CGFloat = 24
        
        // Colors
        static let backgroundColor: UIColor = .systemBackground
        static let titleColor: UIColor = .label
        static let descriptionColor: UIColor = .secondaryLabel
        static let dateColor: UIColor = .tertiaryLabel
        static let iconColor: UIColor = .systemBlue
        
        // Fonts
        static let titleFont: UIFont = .systemFont(ofSize: 16, weight: .semibold)
        static let descriptionFont: UIFont = .systemFont(ofSize: 14, weight: .regular)
        static let dateFont: UIFont = .systemFont(ofSize: 12, weight: .medium)
        
        // Spacing
        static let iconTop: CGFloat = 16
        static let iconLeading: CGFloat = 16
        static let titleTop: CGFloat = 16
        static let titleLeading: CGFloat = 12
        static let titleTrailing: CGFloat = 16
        static let descriptionTop: CGFloat = 4
        static let descriptionTrailing: CGFloat = 16
        static let dateTop: CGFloat = 12
        static let dateTrailing: CGFloat = 16
        static let dateBottom: CGFloat = 16
        static let dateSpacing: CGFloat = 8
    }
}
