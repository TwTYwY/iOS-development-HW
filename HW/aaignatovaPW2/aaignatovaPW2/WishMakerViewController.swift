//
//  ViewController.swift
//  aaignatovaPW2
//
//  Created by Anzhelika Ignatova on 20.09.2025.
//

import UIKit
// MARK: - Creating hex colors
extension UIColor {
    // MARK: Constants
    private enum const{
        static let maxHex: CGFloat = 255.0
        static let twoFirstNum: Int = 0xFF
        static let redShift: Int = 16
        static let greenShift: Int = 8
    }
    // MARK: Initializing UIColor
    convenience init(hex: Int, alpha: CGFloat = 1.0) {
        let red = CGFloat((hex >> const.redShift) & const.twoFirstNum) / const.maxHex
        let green = CGFloat((hex >> const.greenShift) & const.twoFirstNum) / const.maxHex
        let blue = CGFloat(hex & const.twoFirstNum) / const.maxHex
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}
// MARK: - ViewController
final class WishMakerController: UIViewController {
    private let titleLabel = UILabel()
    private let discription = UILabel()
    private let stack = UIStackView()
    private let button = UIButton()
    private let picker = UIPickerView()
    private let pinkColor = UIColor(hex: 0xFFB6C1)
    private let colorMin: CGFloat = 0
    private let colorMax: CGFloat = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        view.backgroundColor = .systemPink
        configureTitle()
        configureDiscription()
        configureSliders()
        stack.isHidden = true
        configureButtonSliders()
    }
    //MARK: - Creating Title
    private func configureTitle() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "WishMaker"
        titleLabel.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        titleLabel.textColor = pinkColor
        
        view.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30)
        ])
    }
    // MARK: - Creating Discription
    private func configureDiscription() {
        discription.translatesAutoresizingMaskIntoConstraints = false
        discription.text = "Welcome to wish maker app!\n Push the button if you want to change the color of the screen!"
        discription.font = UIFont.systemFont(ofSize: 20)
        discription.numberOfLines = 0
        
        view.addSubview(discription)
        NSLayoutConstraint.activate([
            discription.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            discription.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            discription.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20)
        ])
    }
    // MARK: - Creating Slidebars
    private func configureSliders() {
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        view.addSubview(stack)
        stack.layer.cornerRadius = 20
        stack.clipsToBounds = true
        
        let sliderRed = CustomSlider(title: "Red", min: colorMin, max: colorMax)
        let sliderBlue = CustomSlider(title: "Blue", min: colorMin, max: colorMax)
        let sliderGreen = CustomSlider(title: "Green", min: colorMin, max: colorMax)
        
        for slider in [sliderRed, sliderBlue, sliderGreen] {
            stack.addArrangedSubview(slider)
        }
        
        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40)
        ])
        
        sliderRed.valueChanged = { [weak self] value in
            self?.view.backgroundColor = UIColor(red: CGFloat(sliderRed.slider.value), green: CGFloat(sliderGreen.slider.value), blue: CGFloat(sliderBlue.slider.value), alpha: 1)
        }
        
        sliderBlue.valueChanged = { [weak self] value in
            self?.view.backgroundColor = UIColor(red: CGFloat(sliderRed.slider.value), green: CGFloat(sliderGreen.slider.value), blue: CGFloat(sliderBlue.slider.value), alpha: 1)
        }
        
        sliderGreen.valueChanged = { [weak self] value in
            self?.view.backgroundColor = UIColor(red: CGFloat(sliderRed.slider.value), green: CGFloat(sliderGreen.slider.value), blue: CGFloat(sliderBlue.slider.value), alpha: 1)
        }
    }
    // MARK: - Creating Button for sliders
    private func configureButtonSliders() {
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = pinkColor
        button.setTitle("Make a wish", for: .normal)
        button.layer.cornerRadius = 15
        
        button.addTarget(self, action: #selector(buttonSlidersTapped), for: .touchUpInside)
        
        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.topAnchor.constraint(equalTo: discription.bottomAnchor, constant: 20),
            button.widthAnchor.constraint(equalToConstant: 200),
            button.heightAnchor.constraint(equalToConstant: 30)
        ])
        
    }
    // MARK: - If button for sliders was tapped
    @objc private func buttonSlidersTapped() {
        if stack.isHidden {
            stack.isHidden = false
            button.setTitle("Hide sliders", for: .normal)
        } else {
            stack.isHidden = true
            button.setTitle("Make a wish", for: .normal)
        }
    }
    // MARK: - Creating Buttons to
}
// MARK: - Slider's class
final class CustomSlider: UIView {
    var valueChanged: ((Double) -> Void)?
    
    var slider = UISlider()
    var titleView = UILabel()
    
    init(title: String, min: Double, max: Double) {
        super.init(frame: .zero)
        titleView.text = title
        slider.minimumValue = Float(min)
        slider.maximumValue = Float(max)
        slider.addTarget(self, action: #selector(handleValueChanged), for: .valueChanged)
        configureUI()
    }
    
    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        backgroundColor = .white
        translatesAutoresizingMaskIntoConstraints = false
        
        for view in [slider, titleView] {
            addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            titleView.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            titleView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            
            slider.topAnchor.constraint(equalTo: titleView.bottomAnchor),
            slider.centerXAnchor.constraint(equalTo: centerXAnchor),
            slider.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            slider.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20)
        ])
    }
    
    @objc
    private func handleValueChanged() {
        valueChanged?(Double(slider.value))
    }
}
