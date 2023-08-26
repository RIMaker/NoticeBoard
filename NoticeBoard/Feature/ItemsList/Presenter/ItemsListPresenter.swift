//
//  ItemsListPresenter.swift
//  NoticeBoard
//
//  Created by Zhora Agadzhanyan on 24.08.2023.
//

import Foundation

final class ItemsListPresenter: ItemsListViewOutput {
    
    weak var input: ItemsListViewInput?
    
    private let itemsListRepository: ItemsListRepositoryContract
    private let router: ItemsListViewRouting
    
    required init(itemsListRepository: ItemsListRepositoryContract, router: ItemsListViewRouting) {
        self.itemsListRepository = itemsListRepository
        self.router = router
    }
    
    func viewShown() {
        input?.setup()
        
    }
    
    func showItemDetails(at indexPath: IndexPath) {
        
    }
    
}
