//
//  ItemDetailsPresenter.swift
//  NoticeBoard
//
//  Created by Zhora Agadzhanyan on 24.08.2023.
//

import Foundation

final class ItemDetailsPresenter: ItemDetailsViewOutput {
    
    enum InputCells: Int, CaseIterable {
        case image
        case title
        case price
        case address
        case phone
        case email
        case description
        case date
    }
    
    weak var input: ItemDetailsViewInput?
    
    private var itemId: String?
    private var response: AdvertisementDetails?
    
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
        input?.didSelectItemAt = { [weak self] indexPath in
            self?.handleDidSelectItemAt(indexPath)
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
        self.response = response
        let cellModels = InputCells.allCases.map { cell in
            switch cell {
            case .image:
                return NBCollectionViewModel(
                    data: ImageCellData(imageUrl: response.imageUrl),
                    cellType: ImageCollectionViewCell.self
                )
            case .title:
                return NBCollectionViewModel(
                    data: TextCellData(text: response.title, font: .bold, fontSize: 24, color: .black),
                    cellType: TextCollectionViewCell.self
                )
            case .price:
                return NBCollectionViewModel(
                    data: TextCellData(text: response.price, font: .bold, fontSize: 24, color: .black),
                    cellType: TextCollectionViewCell.self
                )
            case .address:
                let address = setupAddress(fromResponse: response)
                return NBCollectionViewModel(
                    data: AddressCellData(address: address),
                    cellType: AddressCollectionViewCell.self
                )
            case .phone:
                return NBCollectionViewModel(
                    data: ContactCellData(contact: response.phoneNumber, type: .phone),
                    cellType: ContactCollectionViewCell.self
                )
            case .email:
                return NBCollectionViewModel(
                    data: ContactCellData(contact: response.email, type: .email),
                    cellType: ContactCollectionViewCell.self
                )
            case .description:
                return NBCollectionViewModel(
                    data: DescriptionCellData(description: response.description),
                    cellType: DescriptionCollectionViewCell.self
                )
            case .date:
                let text: String
                if let createdDate = response.createdDate {
                    text = "Создано \n\(DateFormatter.ddMMyyyy.string(from: createdDate))"
                } else {
                    text = ""
                }
                return NBCollectionViewModel(
                    data: TextCellData(text: text, font: .regular, fontSize: 12, color: .gray),
                    cellType: TextCollectionViewCell.self
                )
            }
        }
        input?.state = .content
        input?.display(models: cellModels)
    }
    
    private func handleAdvertisementsLoading(_ error: NetworkError) {
        
        input?.state = .error(error: error) { [weak self] in
            self?.fetchAdvertisementDetails()
        }
        
    }
    
    private func handleDidSelectItemAt(_ indexPath: IndexPath) {
        guard let cell = InputCells(rawValue: indexPath.item) else { return }
        
        switch cell {
        case .image:
            input?.displayImage(fromUrl: response?.imageUrl)
        case .address:
            let address = setupAddress(fromResponse: response)
            showAddressOnMap(address)
        case .phone:
            callPhoneNumber(response?.phoneNumber)
        case .email:
            textToEmail(response?.email)
        default:
            break
        }
    }
    
    private func setupAddress(fromResponse response: AdvertisementDetails?) -> String {
        var newAddress = response?.location ?? ""
        if let address = response?.address {
            newAddress += ", \(address)"
        }
        return newAddress
    }
    
    private func showAddressOnMap(_ address: String?) {
        guard let address else { return }
        
        let path = "http://maps.apple.com/?q=\(address)".encodeUrl
       
        router.openUrl(fromPath: path)
    }
    
    private func callPhoneNumber(_ phoneNumber: String?) {
        guard let phoneNumber else { return }
        
        let path = "tel://\(phoneNumber.filter{ $0 != " " })"
        router.openUrl(fromPath: path)
    }
    
    private func textToEmail(_ email: String?) {
        guard let email else { return }
        
        let path = "mailto:\(email)"
        router.openUrl(fromPath: path)
    }
    
}
