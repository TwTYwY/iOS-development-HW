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
        static let sectionsCount: Int = 2
        static let wishesKey = "wishesKey"
    }
    private let defaults = UserDefaults.standard
    private let table: UITableView = UITableView(frame: .zero)
    private var wishArray: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        
        if let savedWishes = defaults.array(forKey: Constants.wishesKey) as? [String] {
            wishArray = savedWishes
        } else {
            wishArray = ["I wish to add cells to the table"]
        }
        
        configureTable()
    }
    
    private func configureTable() {
        view.addSubview(table)
        table.backgroundColor = .red
        table.dataSource = self
        table.separatorStyle = .none
        table.layer.cornerRadius = Constants.tableCornerRadius
        
        table.allowsSelection = false
        table.isUserInteractionEnabled = true
        
        table.pin(to: view, Constants.tableOffset)
        table.register(WrittenWishCell.self, forCellReuseIdentifier: WrittenWishCell.reuseId)
        table.register(AddWishCell.self, forCellReuseIdentifier: AddWishCell.reuseId)
    }
}

extension WishStoringViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return Constants.sectionsCount
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return wishArray.count
        default:
            return 0
        }
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: AddWishCell.reuseId,
                for: indexPath
            )
            
            guard let addWishCell = cell as? AddWishCell else {
                return cell
            }
            
            addWishCell.addWish = { [weak self] wish in
                guard let self = self else { return }
                if self.wishArray == ["I wish to add cells to the table"] {
                    self.wishArray.removeAll()
                }
                self.wishArray.append(wish)
                self.defaults.set(self.wishArray, forKey: Constants.wishesKey)
                self.table.reloadData()
            }
            
            return addWishCell
            
        case 1:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: WrittenWishCell.reuseId,
                for: indexPath
            )
            
            guard let wishCell = cell as? WrittenWishCell else {
                return cell
            }
            
            wishCell.configure(with: wishArray[indexPath.row])
            
            return wishCell
            
        default:
            return UITableViewCell()
        }
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return indexPath.section == 1
    }

    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        if editingStyle == .delete && indexPath.section == 1 {
            wishArray.remove(at: indexPath.row)
            defaults.set(wishArray, forKey: Constants.wishesKey)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
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

final class AddWishCell: UITableViewCell {
    static let reuseId: String = "AddWishCell"
    
    private enum Constants {
        static let wrapColor: UIColor = .white
        static let wrapRadius: CGFloat = 16
        static let wrapOffsetV: CGFloat = 5
        static let wrapOffsetH: CGFloat = 10
        static let textViewColor: UIColor = .lightGray
        static let textViewRadius: CGFloat = 8
        static let textViewOffset: CGFloat = 8
        static let textViewFont: UIFont = .systemFont(ofSize: 16)
        static let textViewContainerSize: UIEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        static let buttonText: String = "Add Wish"
        static let buttonColor: UIColor = .white
        static let buttonTextColor: UIColor = .systemPink
        static let buttonH: CGFloat = 45
        static let buttonOffset: CGFloat = 8
    }
    
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
        selectionStyle = .none
        backgroundColor = .clear
        
        let wrap: UIView = UIView()
        contentView.addSubview(wrap)
        
        wrap.backgroundColor = Constants.wrapColor
        wrap.layer.cornerRadius = Constants.wrapRadius
        wrap.pinVertical(to: contentView, top: Constants.wrapOffsetV, bottom: Constants.wrapOffsetH)
        wrap.pinHorizontal(to: contentView, left: Constants.wrapOffsetH, right: Constants.wrapOffsetH)
        
        textView.isUserInteractionEnabled = true
        textView.isEditable = true
        textView.isSelectable = true
        
        wrap.addSubview(textView)
        
        textView.backgroundColor = Constants.textViewColor
        textView.layer.cornerRadius = Constants.textViewRadius
        textView.font = Constants.textViewFont
        textView.textContainerInset = Constants.textViewContainerSize
        textView.isScrollEnabled = true
        textView.isEditable = true
        textView.text = "Enter your wish here..."
        textView.textColor = .darkGray
        
        setupTextView()
        
        wrap.addSubview(addButton)
        
        addButton.setTitle(Constants.buttonText, for: .normal)
        addButton.backgroundColor = Constants.buttonColor
        addButton.setTitleColor(Constants.buttonTextColor, for: .normal)
        addButton.layer.cornerRadius = Constants.textViewRadius
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        addButton.translatesAutoresizingMaskIntoConstraints = false
                
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: wrap.topAnchor, constant: Constants.textViewOffset),
            textView.leadingAnchor.constraint(equalTo: wrap.leadingAnchor, constant: Constants.textViewOffset),
            textView.trailingAnchor.constraint(equalTo: wrap.trailingAnchor, constant: -Constants.textViewOffset),
            textView.heightAnchor.constraint(equalToConstant: 80),
                    
            addButton.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: Constants.buttonOffset),
            addButton.leadingAnchor.constraint(equalTo: wrap.leadingAnchor, constant: Constants.textViewOffset),
            addButton.trailingAnchor.constraint(equalTo: wrap.trailingAnchor, constant: -Constants.textViewOffset),
            addButton.bottomAnchor.constraint(equalTo: wrap.bottomAnchor, constant: -Constants.buttonOffset),
            addButton.heightAnchor.constraint(equalToConstant: Constants.buttonH)
        ])
    }
    
    private func setupTextView() {
        textView.delegate = self
    }
    
    @objc private func activateTextView() {
        textView.becomeFirstResponder()
        if textView.textColor == .darkGray && textView.text == "Enter your wish here..." {
            textView.text = ""
            textView.textColor = .black
        }
    }
    
    @objc private func addButtonTapped() {
        let wishText = textView.textColor == .darkGray ? "" : textView.text
        guard let wish = wishText, !wish.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            return
        }
                
        addWish?(wish)
        textView.text = "Enter your wish here..."
        textView.textColor = .darkGray
        textView.resignFirstResponder()
    }
}

extension AddWishCell: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .darkGray && textView.text == "Enter your wish here..." {
            textView.text = ""
            textView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            textView.text = "Enter your wish here..."
            textView.textColor = .darkGray
        }
    }
}
