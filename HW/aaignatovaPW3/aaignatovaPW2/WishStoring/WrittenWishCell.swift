//
//  WrittenWishCell.swift
//  aaignatovaPW2
//
//  Created by Anzhelika Ignatova on 13.01.2026.
//

import UIKit

final class WrittenWishCell: UITableViewCell {
    static let reuseId: String = "WrittenWishCell"
    
    private let wishLabel: UILabel = UILabel()
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with wish: String) {
        wishLabel.text = wish
    }
    
    private func configureUI() {
        selectionStyle = .none
        backgroundColor = WishStoringConstants.WrittenWishCell.clearBackgroundColor
        
        let wrap: UIView = UIView()
        addSubview(wrap)
        
        wrap.backgroundColor = WishStoringConstants.WrittenWishCell.wrapColor
        wrap.layer.cornerRadius = WishStoringConstants.WrittenWishCell.wrapRadius
        wrap.pinVertical(to: self, top: WishStoringConstants.WrittenWishCell.wrapOffsetV, bottom: WishStoringConstants.WrittenWishCell.wrapOffsetV)
        wrap.pinHorizontal(to: self, left: WishStoringConstants.WrittenWishCell.wrapOffsetH, right: WishStoringConstants.WrittenWishCell.wrapOffsetH)
        
        wrap.addSubview(wishLabel)
        
        wishLabel.textColor = WishStoringConstants.WrittenWishCell.wishLabelTextColor
        wishLabel.numberOfLines = 0
        wishLabel.textAlignment = .left
        
        wishLabel.pin(to: wrap, UIEdgeInsets(
            top: WishStoringConstants.WrittenWishCell.wishLabelOffset,
            left: WishStoringConstants.WrittenWishCell.wishLabelOffset,
            bottom: WishStoringConstants.WrittenWishCell.wishLabelOffset,
            right: WishStoringConstants.WrittenWishCell.wishLabelOffset
        ))
    }
}
