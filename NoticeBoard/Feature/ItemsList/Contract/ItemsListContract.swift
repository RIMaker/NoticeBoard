//
//  ItemsListContract.swift
//  NoticeBoard
//
//  Created by Zhora Agadzhanyan on 24.08.2023.
//

import UIKit

// MARK: - View
protocol ItemsListViewInput: AnyObject {
    var state: NBViewControllerState { get set }
    var onTopRefresh: (() -> ())? { get set }
    var didSelectItemAt: ((_ indexPath: IndexPath) -> ())? { get set }
    func setup()
    func display(models: [NBCollectionViewModel])
}

// MARK: - Presenter
protocol ItemsListViewOutput: AnyObject {
    init(itemsListRepository: ItemsListRepositoryContract, router: ItemsListViewRouting)
    func viewShown()
}

// MARK: - Router
protocol ItemsListViewRouting: BaseRouterContract {
    func showItemDetails(withId itemId: String?)
}

