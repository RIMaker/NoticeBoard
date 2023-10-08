//
//  ItemsListViewController.swift
//  NoticeBoard
//
//  Created by Zhora Agadzhanyan on 24.08.2023.
//

import UIKit

final class ItemsListViewController: NBViewController {
    
    var output: ItemsListViewOutput?
    
    private lazy var collectionView = NBCollectionView(columns: 2)
    
    override func loadView() {
        super.loadView()
        contentView = collectionView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        output?.viewShown()
    }
    
    private func setupViews() {
        title = Constants.ItemsListViewController.title
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
    }
    
    func display(models: [NBCollectionViewModel]) {
        collectionView.display(models: models)
    }
 
}

