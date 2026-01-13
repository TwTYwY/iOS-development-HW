//
//  WishCalendarConstants.swift
//  aaignatovaPW2
//
//  Created by Anzhelika Ignatova on 13.01.2026.
//
import UIKit

enum WishCalendarConstants {
    enum Common {
        static let horizontalPadding: CGFloat = 16
        static let verticalPadding: CGFloat = 20
        static let cornerRadius: CGFloat = 8
        static let shadowRadius: CGFloat = 4
        static let shadowOpacity: Float = 0.1
        static let shadowOffset = CGSize(width: 0, height: 2)
        static let borderWidth: CGFloat = 1
    }
    
    enum EventCreation {
        // Layout
        static let contentHeight: CGFloat = 420
        static let textFieldHeight: CGFloat = 44
        static let textViewHeight: CGFloat = 100
        static let buttonHeight: CGFloat = 50
        
        // Spacing
        static let topPadding: CGFloat = 20
        static let elementSpacing: CGFloat = 16
        static let groupSpacing: CGFloat = 4
        static let buttonTopSpacing: CGFloat = 32
        static let buttonBottomSpacing: CGFloat = 20
        
        // Fonts
        static let titleFontSize: CGFloat = 16
        static let descriptionFontSize: CGFloat = 14
        static let labelFontSize: CGFloat = 14
        static let buttonFontSize: CGFloat = 16
        
        // Font Weights
        static let titleFontWeight: UIFont.Weight = .medium
        static let labelFontWeight: UIFont.Weight = .medium
        static let buttonFontWeight: UIFont.Weight = .semibold
        
        // Colors
        static let buttonBackgroundColor: UIColor = .systemBlue
        static let buttonTextColor: UIColor = .white
        static let borderColor: UIColor = .systemGray4
        static let placeholderTextColor: UIColor = .placeholderText
    }
    
    enum Calendar {
        // Layout
        static let addButtonSize: CGFloat = 50
        static let addButtonCornerRadius: CGFloat = 25
        static let addButtonBottomPadding: CGFloat = 20
        static let addButtonTrailingPadding: CGFloat = 20
        static let collectionViewTopPadding: CGFloat = 0
        
        // Icons
        static let addButtonIconName: String = "plus.circle.fill"
    }
    
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
        static let descriptionTop: CGFloat = 8
        static let descriptionTrailing: CGFloat = 16
        static let dateTop: CGFloat = 12
        static let dateTrailing: CGFloat = 16
        static let dateBottom: CGFloat = 16
        static let dateSpacing: CGFloat = 8
        
        // Icons
        static let meetingIconName: String = "person.2.fill"
        static let birthdayIconName: String = "gift.fill"
        static let defaultIconName: String = "calendar.circle.fill"
    }
    
    enum DateFormat {
        static let displayFormat: String = "yyyy-MM-dd HH:mm"
        static let dateStyle: DateFormatter.Style = .medium
        static let timeStyle: DateFormatter.Style = .short
    }
}
