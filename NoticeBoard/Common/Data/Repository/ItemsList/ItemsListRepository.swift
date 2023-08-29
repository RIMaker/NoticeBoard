//
//  ItemsListRepositoryImpl.swift
//  NoticeBoard
//
//  Created by Zhora Agadzhanyan on 24.08.2023.
//

import Foundation

protocol ItemsListRepositoryContract: AnyObject {
    func getAdvertisements(completion: @escaping (Result<[Advertisement], NetworkError>)->Void)
}

final class ItemsListRepositoryImpl: BaseRepository, ItemsListRepositoryContract {
    
    func getAdvertisements(completion: @escaping (Result<[Advertisement], NetworkError>)->Void) {
        networkClient.send(request: API.AdvertisementsRequest()) { result in
            switch result {
            case .success(let advertisements):
                guard let advertisements = advertisements.advertisements else {
                    completion(.failure(.noData))
                    return
                }
                completion(.success(advertisements))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
