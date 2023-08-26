//
//  ItemsListContract.swift
//  NoticeBoard
//
//  Created by Zhora Agadzhanyan on 24.08.2023.
//

import UIKit

// MARK: - View
@MainActor protocol ItemsListViewInput: AnyObject {
    func setup()
    func refreshViews()
}

// MARK: - Presenter
protocol ItemsListViewOutput: AnyObject {
    init(itemsListRepository: ItemsListRepositoryContract, router: ItemsListViewRouting)
    @MainActor func viewShown()
    func showItemDetails(at indexPath: IndexPath)
}

// MARK: - Router
@MainActor protocol ItemsListViewRouting: BaseRouterContract {
    func showItemDetails(withId itemId: Int?)
}

