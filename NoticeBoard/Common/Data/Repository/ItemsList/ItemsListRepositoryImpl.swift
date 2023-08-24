//
//  ItemsListRepositoryImpl.swift
//  NoticeBoard
//
//  Created by Zhora Agadzhanyan on 24.08.2023.
//

import Foundation

final class ItemsListRepositoryImpl: BaseRepository, ItemsListRepositoryContract {
    
    static let shared = ItemsListRepositoryImpl()
    
    private override init() {}
    
}
