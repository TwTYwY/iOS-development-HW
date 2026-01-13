//
//  WishCalendarViewController.swift
//  aaignatovaPW2
//
//  Created by Anzhelika Ignatova on 13.01.2026.
//

import UIKit

// MARK: - ViewController
final class WishCalendarViewController: UIViewController {
    private let collectionView: UICollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    )
    internal var events: [WishEventModel] = []
    private let addButton: UIButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setupNavigationBar()
        loadEvents()
    }
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
        configureCollection()
        configureAddButton()
    }
    
    private func setupNavigationBar() {
        title = "Wish Calendar"
    }
    
    private func configureCollection() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        collectionView.alwaysBounceVertical = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.contentInset = WishCalendarConstants.CollectionView.insets
        
        collectionView.register(WishEventCell.self, forCellWithReuseIdentifier: "WishEventCell")
        
        view.addSubview(collectionView)
        
        collectionView.pinHorizontal(to: view)
        collectionView.pinBottom(to: view.safeAreaLayoutGuide.bottomAnchor)
        collectionView.pinTop(to: view.safeAreaLayoutGuide.topAnchor, WishCalendarConstants.CollectionView.collectionTop)
    }

    private func configureAddButton() {
        view.addSubview(addButton)
        
        addButton.setImage(UIImage(systemName: WishCalendarConstants.Calendar.addButtonIconName), for: .normal)
        addButton.tintColor = .systemBlue
        addButton.backgroundColor = .systemBackground
        addButton.layer.cornerRadius = WishCalendarConstants.Calendar.addButtonCornerRadius
        addButton.layer.shadowColor = UIColor.black.cgColor
        addButton.layer.shadowOffset = WishCalendarConstants.Common.shadowOffset
        addButton.layer.shadowRadius = WishCalendarConstants.Common.shadowRadius
        addButton.layer.shadowOpacity = WishCalendarConstants.Common.shadowOpacity
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        
        addButton.setWidth(WishCalendarConstants.Calendar.addButtonSize)
        addButton.setHeight(WishCalendarConstants.Calendar.addButtonSize)
        addButton.pinBottom(to: view.safeAreaLayoutGuide.bottomAnchor, WishCalendarConstants.Calendar.addButtonBottomPadding)
        addButton.pinRight(to: view, WishCalendarConstants.Calendar.addButtonTrailingPadding)
    }
    
    @objc private func addButtonTapped() {
        let creationVC = WishEventCreationView()
        let navController = UINavigationController(rootViewController: creationVC)
        creationVC.onEventSaved = { [weak self] event in
            self?.saveEvent(event)
        }
        present(navController, animated: true)
    }
    
    private func loadEvents() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        events = [
            WishEventModel(
                title: "Team Meeting",
                description: "Weekly team sync meeting",
                startDate: dateFormatter.date(from: "2026-01-15 10:00"),
                endDate: dateFormatter.date(from: "2026-01-15 11:00")
            ),
            WishEventModel(
                title: "Birthday Party",
                description: "John's birthday celebration",
                startDate: dateFormatter.date(from: "2026-01-20 19:00"),
                endDate: dateFormatter.date(from: "2026-01-20 23:00")
            )
        ]
        
        print("Loaded \(events.count) events")
        
        collectionView.reloadData()
    }
    
    private func saveEvent(_ event: WishEventModel) {
        events.append(event)
        collectionView.reloadData()
    }
}
