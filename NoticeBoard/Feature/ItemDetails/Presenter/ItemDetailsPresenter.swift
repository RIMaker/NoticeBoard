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
        input?.onTopRefresh = { [weak self] in
            self?.fetchAdvertisementDetails()
        }
        
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
        let model = NBViewModel(data: ItemDetailsViewData(
            showAddressOnMapHandler: { [weak self] address in
                self?.showAddressOnMap(address)
            }, callPhoneNumberHandler: { [weak self] phoneNumber in
                self?.callPhoneNumber(phoneNumber)
            }, textToEmailHandler: { [weak self] email in
                self?.textToEmail(email)
            },
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
    
    private func showAddressOnMap(_ address: String?) {
        guard let address else { return }
        
        let path = "http://maps.apple.com/?q=\(address)".encodeUrl
        if let url = URL(string: path) {
            router.openUrl(url)
        } else {
            self.input?.state = .error(error: .cantBuildUrlFromRequest)
        }
        
    }
    
    private func callPhoneNumber(_ phoneNumber: String?) {
        guard let phoneNumber else { return }
        
        if let url = URL(string: "tel://\(phoneNumber.filter{ $0 != " " })") {
            router.openUrl(url)
        } else {
            self.input?.state = .error(error: .cantBuildUrlFromRequest)
        }
    }
    
    private func textToEmail(_ email: String?) {
        guard let email else { return }
        
        if let url = URL(string: "mailto:\(email)") {
            router.openUrl(url)
        } else {
            self.input?.state = .error(error: .cantBuildUrlFromRequest)
        }
    }
    
}
