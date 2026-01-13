//
//  WishEventCreationView.swift
//  aaignatovaPW2
//
//  Created by Anzhelika Ignatova on 13.01.2026.
//

import UIKit

final class WishEventCreationView: UIViewController {
    // MARK: - UI Components
    private let titleTextField: UITextField = UITextField()
    private let descriptionTextView: UITextView = UITextView()
    private let startDatePicker: UIDatePicker = UIDatePicker()
    private let endDatePicker: UIDatePicker = UIDatePicker()
    private let startDateLabel: UILabel = UILabel()
    private let endDateLabel: UILabel = UILabel()
    private let scrollView: UIScrollView = UIScrollView()
    private let contentView: UIView = UIView()
    private let saveButton: UIButton = UIButton(type: .system)
    private var dateStackView: UIStackView!
    
    var onEventSaved: ((WishEventModel) -> Void)?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setupKeyboardHandling()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        titleTextField.becomeFirstResponder()
    }
    
    // MARK: - UI Configuration
    private func configureUI() {
        view.backgroundColor = .systemBackground
        
        configureNavigationBar()
        configureScrollView()
        configureTitleTextField()
        configureDescriptionTextView()
        configureDatePickers()
        configureSaveButton()
    }
    
    private func configureNavigationBar() {
        title = "New Event"
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .cancel,
            target: self,
            action: #selector(cancelTapped)
        )
    }
    
    private func configureScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.pin(to: view)
        contentView.pin(to: scrollView)
        contentView.setWidth(view.bounds.width)
        contentView.setHeight(WishCalendarConstants.EventCreation.contentHeight)
    }
    
    private func configureTitleTextField() {
        contentView.addSubview(titleTextField)
        
        titleTextField.placeholder = "Event Title"
        titleTextField.borderStyle = .roundedRect
        titleTextField.font = .systemFont(ofSize: WishCalendarConstants.EventCreation.titleFontSize, weight: WishCalendarConstants.EventCreation.titleFontWeight)
        
        titleTextField.pinTop(to: contentView, WishCalendarConstants.EventCreation.topPadding)
        titleTextField.pinHorizontal(to: contentView, WishCalendarConstants.Common.horizontalPadding)
        titleTextField.setHeight(WishCalendarConstants.EventCreation.textFieldHeight)
    }
    
    private func configureDescriptionTextView() {
        contentView.addSubview(descriptionTextView)
        
        descriptionTextView.text = "Event Description"
        descriptionTextView.font = .systemFont(ofSize: WishCalendarConstants.EventCreation.descriptionFontSize)
        descriptionTextView.textColor = WishCalendarConstants.EventCreation.placeholderTextColor
        descriptionTextView.layer.borderWidth = WishCalendarConstants.Common.borderWidth
        descriptionTextView.layer.borderColor = UIColor.systemGray4.cgColor
        descriptionTextView.layer.cornerRadius = WishCalendarConstants.Common.cornerRadius
        descriptionTextView.textContainerInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        descriptionTextView.delegate = self
        
        descriptionTextView.pinTop(to: titleTextField.bottomAnchor, WishCalendarConstants.EventCreation.elementSpacing)
        descriptionTextView.pinHorizontal(to: contentView, WishCalendarConstants.Common.horizontalPadding)
        descriptionTextView.setHeight(WishCalendarConstants.EventCreation.textViewHeight)
    }
    
    private func configureDatePickers() {
        let dateStackView = UIStackView()
        dateStackView.axis = .vertical
        dateStackView.spacing = WishCalendarConstants.EventCreation.elementSpacing
        dateStackView.distribution = .fill
        
        contentView.addSubview(dateStackView)
        dateStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dateStackView.topAnchor.constraint(equalTo: descriptionTextView.bottomAnchor, constant: WishCalendarConstants.EventCreation.elementSpacing),
            dateStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: WishCalendarConstants.Common.horizontalPadding),
            dateStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -WishCalendarConstants.Common.horizontalPadding)
        ])
        
        let startDateGroup = UIStackView()
        startDateGroup.axis = .vertical
        startDateGroup.spacing = WishCalendarConstants.EventCreation.groupSpacing
        startDateGroup.alignment = .leading
        
        startDateLabel.text = "Start Date"
        startDateLabel.font = .systemFont(ofSize: WishCalendarConstants.EventCreation.labelFontSize, weight: WishCalendarConstants.EventCreation.labelFontWeight)
        startDateGroup.addArrangedSubview(startDateLabel)
        
        startDatePicker.datePickerMode = .dateAndTime
        if #available(iOS 13.4, *) {
            startDatePicker.preferredDatePickerStyle = .compact
        }
        startDateGroup.addArrangedSubview(startDatePicker)
        
        dateStackView.addArrangedSubview(startDateGroup)
        
        let endDateGroup = UIStackView()
        endDateGroup.axis = .vertical
        endDateGroup.spacing = WishCalendarConstants.EventCreation.groupSpacing
        endDateGroup.alignment = .leading
        
        endDateLabel.text = "End Date (Optional)"
        endDateLabel.font = .systemFont(ofSize: WishCalendarConstants.EventCreation.labelFontSize, weight: WishCalendarConstants.EventCreation.labelFontWeight)
        endDateGroup.addArrangedSubview(endDateLabel)
        
        endDatePicker.datePickerMode = .dateAndTime
        if #available(iOS 13.4, *) {
            endDatePicker.preferredDatePickerStyle = .compact
        }
        endDateGroup.addArrangedSubview(endDatePicker)
        
        dateStackView.addArrangedSubview(endDateGroup)
        
        self.dateStackView = dateStackView
    }
    
    private func configureSaveButton() {
        contentView.addSubview(saveButton)
        
        saveButton.setTitle("Save Event", for: .normal)
        saveButton.titleLabel?.font = .systemFont(ofSize: WishCalendarConstants.EventCreation.buttonFontSize, weight: WishCalendarConstants.EventCreation.buttonFontWeight)
        saveButton.backgroundColor = WishCalendarConstants.EventCreation.buttonBackgroundColor
        saveButton.setTitleColor(WishCalendarConstants.EventCreation.buttonTextColor, for: .normal)
        saveButton.layer.cornerRadius = WishCalendarConstants.Common.cornerRadius
        saveButton.addTarget(self, action: #selector(saveTapped), for: .touchUpInside)
        
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            saveButton.topAnchor.constraint(equalTo: endDatePicker.bottomAnchor, constant: WishCalendarConstants.EventCreation.buttonTopSpacing),
            saveButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: WishCalendarConstants.Common.horizontalPadding),
            saveButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -WishCalendarConstants.Common.horizontalPadding),
            saveButton.heightAnchor.constraint(equalToConstant: WishCalendarConstants.EventCreation.buttonHeight),
            saveButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -WishCalendarConstants.EventCreation.buttonBottomSpacing)
        ])
    }
    
    // MARK: - Actions
    @objc private func cancelTapped() {
        dismiss(animated: true)
    }
    
    @objc private func saveTapped() {
        guard let title = titleTextField.text, !title.isEmpty else {
            showAlert(title: "Error", message: "Please enter event title")
            return
        }
        
        let description = descriptionTextView.textColor == .placeholderText ? "" : descriptionTextView.text
        let startDate = startDatePicker.date
        let endDate = endDatePicker.date
        
        if endDate < startDate {
            showAlert(title: "Error", message: "End date cannot be earlier than start date")
            return
        }
        
        let event = WishEventModel(
            title: title,
            description: description ?? "",
            startDate: startDate,
            endDate: endDate > startDate ? endDate : nil
        )
        
        onEventSaved?(event)
        dismiss(animated: true)
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    // MARK: - Keyboard Handling
    private func setupKeyboardHandling() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        
        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardFrame.height, right: 0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        scrollView.contentInset = .zero
        scrollView.scrollIndicatorInsets = .zero
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

// MARK: - UITextViewDelegate
extension WishEventCreationView: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .placeholderText {
            textView.text = ""
            textView.textColor = .label
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            textView.text = "Event Description"
            textView.textColor = .placeholderText
        }
    }
}
