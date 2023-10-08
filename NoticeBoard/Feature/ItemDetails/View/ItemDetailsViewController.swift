//
//  ItemDetailsViewController.swift
//  NoticeBoard
//
//  Created by Zhora Agadzhanyan on 24.08.2023.
//

import UIKit

final class ItemDetailsViewController: NBViewController {
    
    var output: ItemDetailsViewOutput?
    
    private lazy var collectionView = NBCollectionView(cellsScalingEffectIsEnable: false)
    
    override func loadView() {
        super.loadView()
        contentView = collectionView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        output?.viewShown()
    }
    
    private func setupViews() {
        title = Constants.ItemDetailsViewController.title
    }
    
}

//MARK: ItemDetailsViewInput
extension ItemDetailsViewController: ItemDetailsViewInput {
    
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


