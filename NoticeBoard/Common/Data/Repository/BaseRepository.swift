//
//  BaseRpository.swift
//  NoticeBoard
//
//  Created by Zhora Agadzhanyan on 26.08.2023.
//

import Foundation

class BaseRepository {
    
    var networkClient: NetworkClientContract
    
    init(networkClient: NetworkClientContract = NetworkClientImpl()) {
        self.networkClient = networkClient
    }
    
}
