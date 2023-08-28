//
//  ItemsListRouter.swift
//  NoticeBoard
//
//  Created by Zhora Agadzhanyan on 24.08.2023.
//

import UIKit

final class ItemsListRouter: BaseRouter, ItemsListViewRouting {
    
    func showItemDetails(withId itemId: String?) {
        route(to: .itemDetails(itemId: itemId))
    }

}
