//
//  CustomSlider.swift
//  aaignatovaPW2
//
//  Created by Anzhelika Ignatova on 13.01.2026.
//

import UIKit

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
    
    @available(*, unavailable)
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
            titleView.topAnchor.constraint(equalTo: topAnchor, constant: WishMakerConstants.Slider.titleTop),
            titleView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: WishMakerConstants.Slider.titleLeading),
            
            slider.topAnchor.constraint(equalTo: titleView.bottomAnchor),
            slider.centerXAnchor.constraint(equalTo: centerXAnchor),
            slider.bottomAnchor.constraint(equalTo: bottomAnchor, constant: WishMakerConstants.Slider.sliderBottom),
            slider.leadingAnchor.constraint(equalTo: leadingAnchor, constant: WishMakerConstants.Slider.titleLeading)
        ])
    }
    
    @objc
    private func handleValueChanged() {
        valueChanged?(Double(slider.value))
    }
}
