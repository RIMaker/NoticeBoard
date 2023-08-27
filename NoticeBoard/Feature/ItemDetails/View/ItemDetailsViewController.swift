//
//  ItemDetailsViewController.swift
//  NoticeBoard
//
//  Created by Zhora Agadzhanyan on 24.08.2023.
//

import UIKit

final class ItemDetailsViewController: NBViewController {
    
    var output: ItemDetailsViewOutput?
    
    private lazy var collectionView = NBCollectionView()

    override func viewDidLoad() {
        super.viewDidLoad()

        output?.viewShown()
    }
    
    private func setupViews() {
        title = Constants.ItemDetailsViewController.title
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

//MARK: ItemDetailsViewInput
extension ItemDetailsViewController: ItemDetailsViewInput {
    
    var onTopRefresh: (() -> ())? {
        get { collectionView.onTopRefresh }
        set { collectionView.onTopRefresh = newValue }
    }
    
    func setup() {
        setupViews()
        setupConstraints()
    }
    
    func display(models: [NBCollectionViewModel]) {
        collectionView.display(models: models)
    }
 
}


