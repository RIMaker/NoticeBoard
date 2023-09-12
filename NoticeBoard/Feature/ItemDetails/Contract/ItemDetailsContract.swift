//
//  ItemDetailsContract.swift
//  NoticeBoard
//
//  Created by Zhora Agadzhanyan on 24.08.2023.
//

import UIKit

// MARK: - View
protocol ItemDetailsViewInput: AnyObject {
    var state: NBViewControllerState { get set }
    var onTopRefresh: (() -> ())? { get set }
    func setup()
    func display(model: NBItemDetailsViewModel) 
}

// MARK: - Presenter
protocol ItemDetailsViewOutput: AnyObject {
    init(itemId: String?, itemDetailsRepository: ItemDetailsRepositoryContract, router: ItemDetailsViewRouting)
    func viewShown()
}

// MARK: - Router
protocol ItemDetailsViewRouting: BaseRouterContract {
    func openUrl(_ url: URL)
}
