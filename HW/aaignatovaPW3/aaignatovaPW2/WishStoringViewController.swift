//
//  WishStoringViewController.swift
//  aaignatovaPW2
//
//  Created by Anzhelika Ignatova on 11.11.2025.
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
}

final class WishStoringViewController: UIViewController {
    struct Constants {
        static let tableCornerRadius: CGFloat = 15
        static let tableOffset: UIEdgeInsets = .init(top: 100, left: 20, bottom: 20, right: 20)
    }
    private let table: UITableView = UITableView(frame: .zero)
    private var wishArray: [String] = ["I wish to add cells to the table"]
    
    override func viewDidLoad() {
        view.backgroundColor = .blue
        configureTable()
    }
    
    private func configureTable() {
        view.addSubview(table)
        table.backgroundColor = .red
        table.dataSource = self
        table.separatorStyle = .none
        table.layer.cornerRadius = Constants.tableCornerRadius
        
        table.pin(to: view, Constants.tableOffset)
        table.register(WrittenWishCell.self, forCellReuseIdentifier: WrittenWishCell.reuseId)
    }
}

extension WishStoringViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wishArray.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: WrittenWishCell.reuseId,
            for: indexPath
        )
        
        guard let wishCell = cell as? WrittenWishCell else {
            return cell
        }
        
        wishCell.configure(with: wishArray[indexPath.row])
        
        return wishCell
    }
}

final class WrittenWishCell: UITableViewCell {
    static let reuseId: String = "WrittenWishCell"
    
    private enum Constants {
        static let wrapColor: UIColor = .white
        static let wrapRadius: CGFloat = 16
        static let wrapOffsetV: CGFloat = 5
        static let wrapOffsetH: CGFloat = 10
        static let wishLabelOffset: CGFloat = 8
    }
    
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
        backgroundColor = .clear
        
        let wrap: UIView = UIView()
        addSubview(wrap)
        
        wrap.backgroundColor = Constants.wrapColor
        wrap.layer.cornerRadius = Constants.wrapRadius
        wrap.pinVertical(to: self, top: Constants.wrapOffsetV, bottom: Constants.wrapOffsetV)
        wrap.pinHorizontal(to: self, left: Constants.wrapOffsetH, right: Constants.wrapOffsetH)
        
        wrap.addSubview(wishLabel)
        
        wishLabel.textColor = .black
        wishLabel.numberOfLines = 0
        wishLabel.textAlignment = .left
        
        wishLabel.pin(to: wrap, UIEdgeInsets(
            top: Constants.wishLabelOffset,
            left: Constants.wishLabelOffset,
            bottom: Constants.wishLabelOffset,
            right: Constants.wishLabelOffset
        ))
    }
}
