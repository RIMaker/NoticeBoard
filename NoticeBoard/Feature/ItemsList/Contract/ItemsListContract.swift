//
//  ItemsListContract.swift
//  NoticeBoard
//
//  Created by Zhora Agadzhanyan on 24.08.2023.
//

import UIKit

// MARK: - View
@MainActor protocol ItemsListViewInput: AnyObject {
    var state: NBViewControllerState { get set }
    var onTopRefresh: (() -> ())? { get set }
    func setup()
    func display(models: [NBCollectionViewModel])
}

// MARK: - Presenter
@MainActor protocol ItemsListViewOutput: AnyObject {
    init(itemsListRepository: ItemsListRepositoryContract, router: ItemsListViewRouting)
    func viewShown()
    func showItemDetails(at indexPath: IndexPath)
}

// MARK: - Router
@MainActor protocol ItemsListViewRouting: BaseRouterContract {
    func showItemDetails(withId itemId: Int?)
}

