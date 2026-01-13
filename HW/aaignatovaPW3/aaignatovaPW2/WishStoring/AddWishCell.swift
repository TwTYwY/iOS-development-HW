//
//  AddWishCell.swift
//  aaignatovaPW2
//
//  Created by Anzhelika Ignatova on 13.01.2026.
//

import UIKit

final class AddWishCell: UITableViewCell {
    static let reuseId: String = "AddWishCell"
    
    var addWish: ((String) -> ())?
    
    private let textView: UITextView = UITextView()
    private let addButton: UIButton = UIButton(type: .system)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    private func configureUI() {
        selectionStyle = WishStoringConstants.AddWishCell.selectionStyle
        backgroundColor = WishStoringConstants.AddWishCell.clearBackgroundColor
        
        let wrap: UIView = UIView()
        contentView.addSubview(wrap)
        
        wrap.backgroundColor = WishStoringConstants.AddWishCell.wrapColor
        wrap.layer.cornerRadius = WishStoringConstants.AddWishCell.wrapRadius
        wrap.pinVertical(to: contentView, top: WishStoringConstants.AddWishCell.wrapOffsetV, bottom: WishStoringConstants.AddWishCell.wrapOffsetH)
        wrap.pinHorizontal(to: contentView, left: WishStoringConstants.AddWishCell.wrapOffsetH, right: WishStoringConstants.AddWishCell.wrapOffsetH)
        
        textView.isUserInteractionEnabled = true
        textView.isEditable = true
        textView.isSelectable = true
        
        wrap.addSubview(textView)
        
        textView.backgroundColor = WishStoringConstants.AddWishCell.textViewColor
        textView.layer.cornerRadius = WishStoringConstants.AddWishCell.textViewRadius
        textView.font = WishStoringConstants.AddWishCell.textViewFont
        textView.textContainerInset = WishStoringConstants.AddWishCell.textViewContainerSize
        textView.isScrollEnabled = true
        textView.isEditable = true
        textView.text = "Enter your wish here..."
        textView.textColor = WishStoringConstants.AddWishCell.placeholderTextColor
        
        setupTextView()
        
        wrap.addSubview(addButton)
        
        addButton.setTitle("Add Wish", for: .normal)
        addButton.backgroundColor = WishStoringConstants.AddWishCell.buttonColor
        addButton.setTitleColor(WishStoringConstants.AddWishCell.buttonTextColor, for: .normal)
        addButton.layer.cornerRadius = WishStoringConstants.AddWishCell.textViewRadius
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        addButton.translatesAutoresizingMaskIntoConstraints = false
                
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: wrap.topAnchor, constant: WishStoringConstants.AddWishCell.textViewOffset),
            textView.leadingAnchor.constraint(equalTo: wrap.leadingAnchor, constant: WishStoringConstants.AddWishCell.textViewOffset),
            textView.trailingAnchor.constraint(equalTo: wrap.trailingAnchor, constant: -WishStoringConstants.AddWishCell.textViewOffset),
            textView.heightAnchor.constraint(equalToConstant: WishStoringConstants.AddWishCell.textViewHeight),
                    
            addButton.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: WishStoringConstants.AddWishCell.buttonOffset),
            addButton.leadingAnchor.constraint(equalTo: wrap.leadingAnchor, constant: WishStoringConstants.AddWishCell.textViewOffset),
            addButton.trailingAnchor.constraint(equalTo: wrap.trailingAnchor, constant: -WishStoringConstants.AddWishCell.textViewOffset),
            addButton.bottomAnchor.constraint(equalTo: wrap.bottomAnchor, constant: -WishStoringConstants.AddWishCell.buttonOffset),
            addButton.heightAnchor.constraint(equalToConstant: WishStoringConstants.AddWishCell.buttonH)
        ])
    }
    
    private func setupTextView() {
        textView.delegate = self
    }
    
    @objc private func activateTextView() {
        textView.becomeFirstResponder()
        if textView.textColor == WishStoringConstants.AddWishCell.placeholderTextColor && textView.text == "Enter your wish here..." {
            textView.text = ""
            textView.textColor = WishStoringConstants.AddWishCell.enteredTextColor
        }
    }
    
    @objc private func addButtonTapped() {
        let wishText = textView.textColor == WishStoringConstants.AddWishCell.placeholderTextColor ? "" : textView.text
        guard let wish = wishText, !wish.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            return
        }
                
        addWish?(wish)
        textView.text = "Enter your wish here..."
        textView.textColor = WishStoringConstants.AddWishCell.placeholderTextColor
        textView.resignFirstResponder()
    }
}

extension AddWishCell: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == WishStoringConstants.AddWishCell.placeholderTextColor && textView.text == "Enter your wish here..." {
            textView.text = ""
            textView.textColor = WishStoringConstants.AddWishCell.enteredTextColor
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            textView.text = "Enter your wish here..."
            textView.textColor = WishStoringConstants.AddWishCell.placeholderTextColor
        }
    }
}
