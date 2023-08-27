//
//  ItemsListViewController.swift
//  NoticeBoard
//
//  Created by Zhora Agadzhanyan on 24.08.2023.
//

import UIKit

final class ItemsListViewController: NBViewController {
    
    var output: ItemsListViewOutput?
    
    private lazy var collectionView = NBCollectionView()

    override func viewDidLoad() {
        super.viewDidLoad()

        output?.viewShown()
    }
    
    private func setupViews() {
        title = Constants.ItemsListViewController.title
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
}

//MARK: ItemsListViewInput
extension ItemsListViewController: ItemsListViewInput {
    
    var onTopRefresh: (() -> ())? {
        get { collectionView.onTopRefresh }
        set { collectionView.onTopRefresh = newValue }
    }
    
    var didSelectItemAt: ((_ indexPath: IndexPath) -> ())? {
        get { collectionView.didSelectItemAt }
        set { collectionView.didSelectItemAt = newValue }
    }
    
    func setup() {
        setupViews()
        setupConstraints()
    }
    
    func display(models: [NBCollectionViewModel]) {
        collectionView.display(models: models)
    }
 
}

