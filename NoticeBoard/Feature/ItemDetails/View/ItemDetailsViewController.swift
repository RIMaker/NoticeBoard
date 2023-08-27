//
//  ItemDetailsViewController.swift
//  NoticeBoard
//
//  Created by Zhora Agadzhanyan on 24.08.2023.
//

import UIKit

final class ItemDetailsViewController: NBViewController {
    
    var output: ItemDetailsViewOutput?
    
    private lazy var itemDetailsView = NBItemDetailsView()

    override func viewDidLoad() {
        super.viewDidLoad()

        output?.viewShown()
    }
    
    private func setupViews() {
        title = Constants.ItemDetailsViewController.title
        itemDetailsView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(itemDetailsView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            itemDetailsView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            itemDetailsView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            itemDetailsView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            itemDetailsView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
}

//MARK: ItemDetailsViewInput
extension ItemDetailsViewController: ItemDetailsViewInput {
    
    func setup() {
        setupViews()
        setupConstraints()
    }
    
    func display(model: NBItemDetailsViewModel) {
        itemDetailsView.update(with: model)
    }
 
}


