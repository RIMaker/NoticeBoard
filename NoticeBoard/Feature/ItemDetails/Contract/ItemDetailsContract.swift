//
//  ItemDetailsContract.swift
//  NoticeBoard
//
//  Created by Zhora Agadzhanyan on 24.08.2023.
//

import UIKit

// MARK: - View
@MainActor protocol ItemDetailsViewInput: AnyObject {
    var state: NBViewControllerState { get set }
    var onTopRefresh: (() -> ())? { get set }
    func setup()
    func display(model: NBItemDetailsViewModel) 
}

// MARK: - Presenter
@MainActor protocol ItemDetailsViewOutput: AnyObject {
    init(itemId: String?, itemDetailsRepository: ItemDetailsRepositoryContract, router: ItemDetailsViewRouting)
    func viewShown()
}

// MARK: - Router
@MainActor protocol ItemDetailsViewRouting: BaseRouterContract {
    func openUrl(_ url: URL)
}
