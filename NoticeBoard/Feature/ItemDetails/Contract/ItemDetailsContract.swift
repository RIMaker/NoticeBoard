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
    var didSelectItemAt: ((_ indexPath: IndexPath) -> ())? { get set }
    func setup()
    func display(models: [NBCollectionViewModel])
    func displayImage(fromUrl url: URL?)
}

// MARK: - Presenter
protocol ItemDetailsViewOutput: AnyObject {
    init(itemId: String?, itemDetailsRepository: ItemDetailsRepositoryContract, router: ItemDetailsViewRouting)
    func viewShown()
}

// MARK: - Router
protocol ItemDetailsViewRouting: BaseRouterContract {
    func openUrl(fromPath path: String)
}
