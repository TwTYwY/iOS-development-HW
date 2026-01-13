//
//  WishStoringViewController.swift
//  aaignatovaPW2
//
//  Created by Anzhelika Ignatova on 11.11.2025.
//

import UIKit

final class WishStoringViewController: UIViewController {
    private let defaults = UserDefaults.standard
    private let table: UITableView = UITableView(frame: .zero)
    private var wishArray: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = WishStoringConstants.View.backgroundColor
        
        if let savedWishes = defaults.array(forKey: "wishesKey") as? [String] {
            wishArray = savedWishes
        } else {
            wishArray = ["I wish to add cells to the table"]
        }
        
        configureTable()
    }
    
    private func configureTable() {
        view.addSubview(table)
        table.backgroundColor = WishStoringConstants.Table.backgroundColor
        table.dataSource = self
        table.separatorStyle = .none
        table.layer.cornerRadius = WishStoringConstants.Table.cornerRadius
        
        table.allowsSelection = false
        table.isUserInteractionEnabled = true
        
        table.pin(to: view, WishStoringConstants.Table.offset)
        table.register(WrittenWishCell.self, forCellReuseIdentifier: WrittenWishCell.reuseId)
        table.register(AddWishCell.self, forCellReuseIdentifier: AddWishCell.reuseId)
    }
}

extension WishStoringViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return WishStoringConstants.Table.sectionsCount
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
                self.defaults.set(self.wishArray, forKey: "wishesKey")
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
            defaults.set(wishArray, forKey: "wishesKey")
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }

}
