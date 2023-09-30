//
//  ItemDetailsViewController.swift
//  NoticeBoard
//
//  Created by Zhora Agadzhanyan on 24.08.2023.
//

import UIKit

final class ItemDetailsViewController: NBViewController {
    
    var output: ItemDetailsViewOutput?
    
    private lazy var itemDetailsView = ItemDetailsView()
    
    override func loadView() {
        view = itemDetailsView
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
        get { itemDetailsView.onTopRefresh }
        set { itemDetailsView.onTopRefresh = newValue }
    }
    
    func setup() {
        setupViews()
    }
    
    func display(model: NBViewModel) {
        itemDetailsView.update(with: model)
    }
 
}


