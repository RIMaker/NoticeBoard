//
//  API.swift
//  NoticeBoard
//
//  Created by Zhora Agadzhanyan on 26.08.2023.
//

import Foundation

enum API {
    
    struct AdvertisementsRequest: NetworkRequestContract {
        typealias Response = AdvertisementsResponse
        
        let path = "s/interns-ios/main-page.json"
        let httpMethod: HTTPMethod = .GET
    }
    
    struct AdvertisementDetailsRequest: NetworkRequestContract {
        typealias Response = AdvertisementDetails
        
        let path: String
        let httpMethod: HTTPMethod = .GET
        
        init(itemId: String) {
            path = "s/interns-ios/details/\(itemId).json"
        }
    }
    
}
