//
//  ViewController.swift
//  aaignatovaPW1
//
//  Created by Anzhelika Ignatova on 10.09.2025.
//

import UIKit

// MARK: - UIColor extension
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
class ViewController: UIViewController {
    @IBOutlet var views: [UIView]!
    @IBOutlet weak var button: UIButton!
    
    // MARK: Constants
    private enum const{
        static let hexesColorRange: ClosedRange<Int> = 0x000000...0xFFFFFF
        static let animationDuration: TimeInterval = 1.0
        static let cornerRadiusRange: ClosedRange<CGFloat> = 0.0...25.0
    }

    // MARK: Function for unique colors
    func getUniqueHexColors () -> [UIColor] {
        var hexSet = Set<Int>()
        while hexSet.count < views.count {
            hexSet.insert(Int.random(in: const.hexesColorRange))
        }
        return hexSet.map {UIColor(hex: $0)}
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    // MARK: Actions after pressing button
    @IBAction func buttonWasPressed(_ sender: Any) {
        var colors = getUniqueHexColors()
        var i = 0
        for view in views{
            UIView.animate(
                withDuration: const.animationDuration,
                animations:{
                    view.backgroundColor = colors[i]
                    view.layer.cornerRadius = .random(in: const.cornerRadiusRange)
                },
                completion: { [weak self] _ in self?.button.isEnabled = true
                }
            )
            i += 1
        }
    }
    

}

