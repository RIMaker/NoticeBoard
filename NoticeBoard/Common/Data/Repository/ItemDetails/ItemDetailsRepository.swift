//
//  ItemDetailsRepository.swift
//  NoticeBoard
//
//  Created by Zhora Agadzhanyan on 26.08.2023.
//

import Foundation

protocol ItemDetailsRepositoryContract: AnyObject {
    func getAdvertisementDetails(itemId: String?, completion: @escaping (Result<AdvertisementDetails, NetworkError>)->Void)
}

final class ItemDetailsRepositoryImpl: BaseRepository, ItemDetailsRepositoryContract {
    
    func getAdvertisementDetails(itemId: String?, completion: @escaping (Result<AdvertisementDetails, NetworkError>)->Void) {
        guard let itemId else {
            completion(.failure(.cantBuildUrlFromRequest))
            return
        }
        networkClient.send(request: API.AdvertisementDetailsRequest(itemId: itemId)) { result in
            switch result {
            case .success(let advertisementDetails):
                completion(.success(advertisementDetails))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
