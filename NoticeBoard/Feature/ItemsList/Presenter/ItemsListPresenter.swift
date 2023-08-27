//
//  ItemsListPresenter.swift
//  NoticeBoard
//
//  Created by Zhora Agadzhanyan on 24.08.2023.
//

import Foundation

final class ItemsListPresenter: ItemsListViewOutput {
    
    weak var input: ItemsListViewInput?
    
    private var advertisements: [Advertisement]?
    
    private let itemsListRepository: ItemsListRepositoryContract
    private let router: ItemsListViewRouting
    
    required init(itemsListRepository: ItemsListRepositoryContract, router: ItemsListViewRouting) {
        self.itemsListRepository = itemsListRepository
        self.router = router
    }
    
    func viewShown() {
        input?.setup()
        input?.onTopRefresh = { [weak self] in
            self?.fetchAdvertisements()
        }
        input?.didSelectItemAt = { [weak self] indexPath in
            self?.showItemDetails(at: indexPath)
        }
        
        fetchAdvertisements()
    }
    
    private func showItemDetails(at indexPath: IndexPath) {
        guard let advertisements, indexPath.item < advertisements.count else { return }
        
        let advertisement = advertisements[indexPath.item]
        
        router.showItemDetails(withId: advertisement.id)
    }
    
    private func fetchAdvertisements() {
        input?.state = .loading
        itemsListRepository.getAdvertisements { [weak self] result in
            switch result {
            case .success(let advertisements):
                self?.handleAdvertisementsLoading(advertisements)
            case .failure(let error):
                self?.handleAdvertisementsLoading(error)
            }
        }
        
    }
    
    private func handleAdvertisementsLoading(_ response: [Advertisement]) {
        self.advertisements = response
        
        let models = response.map {
            NBCollectionViewModel(
                data: ItemCellData(
                    title: $0.title,
                    price: $0.price,
                    location: $0.location,
                    imageUrl: $0.imageUrl,
                    createdDate: $0.createdDate
                ),
                cellType: ItemCollectionViewCell.self
            )
        }
        input?.state = .content
        input?.display(models: models)
    }
    
    private func handleAdvertisementsLoading(_ error: NetworkError) {
        
        input?.state = .error(error: error) { [weak self] in
            self?.fetchAdvertisements()
        }
        
    }
    
}
