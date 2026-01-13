//
//  UIView+Extensions.swift
//  aaignatovaPW2
//
//  Created by Anzhelika Ignatova on 13.01.2026.
//

import UIKit

extension UIView {
    func pin(to view: UIView, _ insets: UIEdgeInsets = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: view.topAnchor, constant: insets.top),
            leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: insets.left),
            trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -insets.right),
            bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -insets.bottom)
        ])
    }
    
    func pinVertical(to view: UIView, top: CGFloat = 0, bottom: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
            
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: view.topAnchor, constant: top),
            bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -bottom)
        ])
    }
        
    func pinHorizontal(to view: UIView, left: CGFloat = 0, right: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
            
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: left),
            trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -right)
        ])
    }
    
    func setHeight(_ height: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    func pinBottom(to view: UIView, _ constant: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -constant).isActive = true
    }
    
    func pinHorizontal(to view: UIView, _ constant: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: constant).isActive = true
        trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -constant).isActive = true
    }
}
