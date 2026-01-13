//
//  WishEventCell.swift
//  aaignatovaPW2
//
//  Created by Anzhelika Ignatova on 13.01.2026.
//

import UIKit

final class WishEventCell: UICollectionViewCell {
    static let reuseIdentifier: String = "WishEventCell"
    private let wrapView: UIView = UIView()
    private let titleLabel: UILabel = UILabel()
    private let descriptionLabel: UILabel = UILabel()
    private let startDateLabel: UILabel = UILabel()
    private let endDateLabel: UILabel = UILabel()
    private let iconImageView: UIImageView = UIImageView()
    private let dateStackView: UIStackView = UIStackView()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    private func configureUI() {
        configureWrap()
        configureIconImageView()
        configureTitleLabel()
        configureDescriptionLabel()
        configureDateStackView()
        configureStartDateLabel()
        configureEndDateLabel()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        descriptionLabel.text = nil
        startDateLabel.text = nil
        endDateLabel.text = nil
    }
    
    // MARK: - Cell Configuration
    func configure(with event: WishEventModel) {
        titleLabel.text = event.title
        descriptionLabel.text = event.description
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        
        if let startDate = event.startDate {
            startDateLabel.text = "Starts: \(dateFormatter.string(from: startDate))"
        } else {
            startDateLabel.text = "Starts: TBD"
        }
        
        if let endDate = event.endDate {
            endDateLabel.text = "Ends: \(dateFormatter.string(from: endDate))"
        } else {
            endDateLabel.text = "Ends: TBD"
        }
        
        // Set appropriate icon based on event type or category
        if event.description.lowercased().contains("meeting") {
            iconImageView.image = UIImage(systemName: "person.2.fill")
        } else if event.title.lowercased().contains("birthday") {
            iconImageView.image = UIImage(systemName: "gift.fill")
        } else {
            iconImageView.image = UIImage(systemName: "calendar.circle.fill")
        }
    }
    
    // MARK: - UI Configuration
    private func configureWrap() {
        addSubview(wrapView)
        wrapView.pin(to: self, WishCalendarConstants.EventCell.offset)
        wrapView.layer.cornerRadius = WishCalendarConstants.EventCell.cornerRadius
        wrapView.backgroundColor = WishCalendarConstants.EventCell.backgroundColor
        wrapView.layer.shadowColor = UIColor.black.cgColor
        wrapView.layer.shadowOffset = CGSize(width: 0, height: 2)
        wrapView.layer.shadowRadius = 4
        wrapView.layer.shadowOpacity = 0.1
        wrapView.layer.masksToBounds = false
    }
    
    private func configureIconImageView() {
        wrapView.addSubview(iconImageView)
        iconImageView.tintColor = WishCalendarConstants.EventCell.iconColor
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.pinTop(to: wrapView, WishCalendarConstants.EventCell.iconTop)
        iconImageView.pinLeft(to: wrapView, WishCalendarConstants.EventCell.iconLeading)
        iconImageView.setWidth(WishCalendarConstants.EventCell.iconSize)
        iconImageView.setHeight(WishCalendarConstants.EventCell.iconSize)
    }
    
    private func configureTitleLabel() {
        wrapView.addSubview(titleLabel)
        titleLabel.textColor = WishCalendarConstants.EventCell.titleColor
        titleLabel.font = WishCalendarConstants.EventCell.titleFont
        titleLabel.pinTop(to: wrapView, WishCalendarConstants.EventCell.titleTop)
        titleLabel.pinLeft(to: iconImageView.trailingAnchor, WishCalendarConstants.EventCell.titleLeading)
        titleLabel.pinRight(to: wrapView, WishCalendarConstants.EventCell.titleTrailing)
        titleLabel.numberOfLines = 1
        titleLabel.lineBreakMode = .byTruncatingTail
    }
    
    private func configureDescriptionLabel() {
        wrapView.addSubview(descriptionLabel)
        descriptionLabel.textColor = WishCalendarConstants.EventCell.descriptionColor
        descriptionLabel.font = WishCalendarConstants.EventCell.descriptionFont
        descriptionLabel.pinTop(to: titleLabel.bottomAnchor, WishCalendarConstants.EventCell.descriptionTop)
        descriptionLabel.pinLeft(to: titleLabel.leadingAnchor)
        descriptionLabel.pinRight(to: wrapView, WishCalendarConstants.EventCell.descriptionTrailing)
        descriptionLabel.numberOfLines = 2
        descriptionLabel.lineBreakMode = .byTruncatingTail
    }
    
    private func configureDateStackView() {
        wrapView.addSubview(dateStackView)
        dateStackView.axis = .horizontal
        dateStackView.distribution = .fillEqually
        dateStackView.spacing = WishCalendarConstants.EventCell.dateSpacing
        dateStackView.pinTop(to: descriptionLabel.bottomAnchor, WishCalendarConstants.EventCell.dateTop)
        dateStackView.pinLeft(to: descriptionLabel.leadingAnchor)
        dateStackView.pinRight(to: wrapView, WishCalendarConstants.EventCell.dateTrailing)
        dateStackView.pinBottom(to: wrapView, WishCalendarConstants.EventCell.dateBottom)
    }
    
    private func configureStartDateLabel() {
        dateStackView.addArrangedSubview(startDateLabel)
        startDateLabel.textColor = WishCalendarConstants.EventCell.dateColor
        startDateLabel.font = WishCalendarConstants.EventCell.dateFont
        startDateLabel.numberOfLines = 2
        startDateLabel.lineBreakMode = .byWordWrapping
    }
    
    private func configureEndDateLabel() {
        dateStackView.addArrangedSubview(endDateLabel)
        endDateLabel.textColor = WishCalendarConstants.EventCell.dateColor
        endDateLabel.font = WishCalendarConstants.EventCell.dateFont
        endDateLabel.numberOfLines = 2
        endDateLabel.lineBreakMode = .byWordWrapping
        endDateLabel.textAlignment = .right
    }
}
