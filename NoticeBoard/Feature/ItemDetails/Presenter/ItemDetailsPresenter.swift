//
//  ItemDetailsPresenter.swift
//  NoticeBoard
//
//  Created by Zhora Agadzhanyan on 24.08.2023.
//

import Foundation

final class ItemDetailsPresenter: ItemDetailsViewOutput {
    
    weak var input: ItemDetailsViewInput?
    
    private var itemId: String?
    
    private let itemDetailsRepository: ItemDetailsRepositoryContract
    private let router: ItemDetailsViewRouting
    
    required init(itemId: String?, itemDetailsRepository: ItemDetailsRepositoryContract, router: ItemDetailsViewRouting) {
        self.itemId = itemId
        self.itemDetailsRepository = itemDetailsRepository
        self.router = router
    }
    
    func viewShown() {
        input?.setup()
        
        fetchAdvertisementDetails()
    }
    
    private func fetchAdvertisementDetails() {
        input?.state = .loading
        itemDetailsRepository.getAdvertisementDetails(itemId: itemId) { [weak self] result in
            switch result {
            case .success(let advertisementDetails):
                self?.handleAdvertisementsLoading(advertisementDetails)
            case .failure(let error):
                self?.handleAdvertisementsLoading(error)
            }
        }
        
    }
    
    private func handleAdvertisementsLoading(_ response: AdvertisementDetails) {
        let model = NBItemDetailsViewModel(data: NBItemDetailsViewModelDataImpl(
            title: response.title,
            price: response.price,
            location: response.location,
            imageUrl: response.imageUrl,
            createdDate: response.createdDate,
            description: response.description,
            email: response.email,
            phoneNumber: response.phoneNumber,
            address: response.address
        ))
        input?.state = .content
        input?.display(model: model)
    }
    
    private func handleAdvertisementsLoading(_ error: NetworkError) {
        
        input?.state = .error(error: error) { [weak self] in
            self?.fetchAdvertisementDetails()
        }
        
    }
    
}
