//
//  ViewController.swift
//  aaignatovaPW2
//
//  Created by Anzhelika Ignatova on 20.09.2025.
//

import UIKit

// MARK: - ViewController
final class WishMakerViewController: UIViewController {
    private let titleLabel = UILabel()
    private let discription = UILabel()
    private let stack = UIStackView()
    private let button = UIButton()
    private let picker = UIPickerView()
    private let addWishButton: UIButton = UIButton(type: .system)
    private let scheduleWishButton: UIButton = UIButton(type: .system)
    private let actionStack = UIStackView()
    
    private var currentColor: UIColor = .systemPink {
        didSet {
            view.backgroundColor = currentColor
            updateButtonTitleColors()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        view.backgroundColor = currentColor
        configureTitle()
        configureDiscription()
        configureActionStack()
        configureSliders()
        stack.isHidden = true
        configureButtonSliders()
    }
    
    private func updateButtonTitleColors() {
        addWishButton.setTitleColor(currentColor, for: .normal)
        scheduleWishButton.setTitleColor(currentColor, for: .normal)
        button.setTitleColor(currentColor, for: .normal)
    }
    //MARK: - Creating Title
    private func configureTitle() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "WishMaker"
        titleLabel.font = UIFont.systemFont(ofSize: WishMakerConstants.Layout.titleFontSize, weight: .bold)
        titleLabel.textColor = WishMakerConstants.Color.pinkColor
        
        view.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: WishMakerConstants.Layout.titleLabelLeading),
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: WishMakerConstants.Layout.titleLabelTop)
        ])
    }
    // MARK: - Creating Discription
    private func configureDiscription() {
        discription.translatesAutoresizingMaskIntoConstraints = false
        discription.text = "Welcome to wish maker app!\n Push the button if you want to change the color of the screen!"
        discription.font = UIFont.systemFont(ofSize: WishMakerConstants.Layout.discriptionFontSize)
        discription.numberOfLines = 0
        
        view.addSubview(discription)
        NSLayoutConstraint.activate([
            discription.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            discription.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: WishMakerConstants.Layout.titleLabelLeading),
            discription.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: WishMakerConstants.Layout.discriptionTop)
        ])
    }
    // MARK: - Creating Slidebars
    private func configureSliders() {
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        view.addSubview(stack)
        stack.layer.cornerRadius = WishMakerConstants.Layout.stackCornerRadius
        stack.clipsToBounds = true
        
        let sliderRed = CustomSlider(title: "Red", min: WishMakerConstants.Color.colorMin, max: WishMakerConstants.Color.colorMax)
        let sliderBlue = CustomSlider(title: "Blue", min: WishMakerConstants.Color.colorMin, max: WishMakerConstants.Color.colorMax)
        let sliderGreen = CustomSlider(title: "Green", min: WishMakerConstants.Color.colorMin, max: WishMakerConstants.Color.colorMax)
        
        for slider in [sliderRed, sliderBlue, sliderGreen] {
            stack.addArrangedSubview(slider)
        }
        
        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: WishMakerConstants.Layout.titleLabelLeading),
            stack.bottomAnchor.constraint(equalTo: addWishButton.topAnchor, constant: WishMakerConstants.Layout.stackBottom)
        ])
        
        sliderRed.valueChanged = { [weak self] value in
            self?.currentColor = UIColor(red: CGFloat(sliderRed.slider.value), green: CGFloat(sliderGreen.slider.value), blue: CGFloat(sliderBlue.slider.value), alpha: WishMakerConstants.Color.fullAlpha)
        }
        
        sliderBlue.valueChanged = { [weak self] value in
            self?.currentColor = UIColor(red: CGFloat(sliderRed.slider.value), green: CGFloat(sliderGreen.slider.value), blue: CGFloat(sliderBlue.slider.value), alpha: WishMakerConstants.Color.fullAlpha)
        }
        
        sliderGreen.valueChanged = { [weak self] value in
            self?.currentColor = UIColor(red: CGFloat(sliderRed.slider.value), green: CGFloat(sliderGreen.slider.value), blue: CGFloat(sliderBlue.slider.value), alpha: WishMakerConstants.Color.fullAlpha)
        }
    }
    // MARK: - Creating Button for sliders
    private func configureButtonSliders() {
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = WishMakerConstants.Color.pinkColor
        button.setTitle("Make a wish", for: .normal)
        button.layer.cornerRadius = WishMakerConstants.Layout.buttonRadius
        
        button.addTarget(self, action: #selector(buttonSlidersPressed), for: .touchUpInside)
        
        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.topAnchor.constraint(equalTo: discription.bottomAnchor, constant: WishMakerConstants.Layout.sliderButtonTop),
            button.widthAnchor.constraint(equalToConstant: WishMakerConstants.Layout.sliderButtonWidth),
            button.heightAnchor.constraint(equalToConstant: WishMakerConstants.Layout.sliderButtonHeight)
        ])
        
    }
    // MARK: - If button for sliders was pressed
    @objc private func buttonSlidersPressed() {
        if stack.isHidden {
            stack.isHidden = false
            button.setTitle("Hide sliders", for: .normal)
        } else {
            stack.isHidden = true
            button.setTitle("Make a wish", for: .normal)
        }
    }
    // MARK: - Creating Button for adding whishes
    private func configureAddWishButton() {
        addWishButton.translatesAutoresizingMaskIntoConstraints = false
        addWishButton.setHeight(WishMakerConstants.Layout.buttonHeight)
        
        addWishButton.backgroundColor = .white
        addWishButton.setTitleColor(currentColor, for: .normal)
        addWishButton.setTitle("My wishes", for: .normal)
        
        addWishButton.layer.cornerRadius = WishMakerConstants.Layout.buttonRadius
        addWishButton.addTarget(self, action: #selector(addWishButtonPressed), for: .touchUpInside)
    }
    // MARK: - Creating Button for scheduling whish-granting activity
    private func configureScheduleWishButton() {
        scheduleWishButton.translatesAutoresizingMaskIntoConstraints = false
        scheduleWishButton.setHeight(WishMakerConstants.Layout.buttonHeight)
        
        scheduleWishButton.backgroundColor = .white
        scheduleWishButton.setTitleColor(currentColor, for: .normal)
        scheduleWishButton.setTitle("Schedule wish granting", for: .normal)
        
        scheduleWishButton.layer.cornerRadius = WishMakerConstants.Layout.buttonRadius
        scheduleWishButton.addTarget(self, action: #selector(scheduleWishButtonPressed), for: .touchUpInside)
    }
    // MARK: - Creating Buttons
    private func configureActionStack() {
        actionStack.axis = .vertical
        view.addSubview(actionStack)
        actionStack.spacing = WishMakerConstants.Layout.buttonSpacing
        actionStack.translatesAutoresizingMaskIntoConstraints = false
        
        configureAddWishButton()
        configureScheduleWishButton()
        
        for button in [addWishButton, scheduleWishButton] {
            actionStack.addArrangedSubview(button)
        }
        
        NSLayoutConstraint.activate([
            actionStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: WishMakerConstants.Layout.buttonSide),
            actionStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -WishMakerConstants.Layout.buttonSide),
            actionStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -WishMakerConstants.Layout.buttonBottom)
        ])
    }
    // MARK: - If button for sliders was pressed
    @objc private func addWishButtonPressed() {
        present(WishStoringViewController(), animated: true)
    }
    
    @objc private func scheduleWishButtonPressed() {
        let vc = WishCalendarViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
