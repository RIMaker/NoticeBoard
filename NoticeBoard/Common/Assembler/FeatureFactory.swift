//
//  FeatureFactory.swift
//  NoticeBoard
//
//  Created by Zhora Agadzhanyan on 24.08.2023.
//

import UIKit

enum ScreenIdentifier {
    case splash
    case main
    case itemDetails(itemId: String?)
}


@MainActor protocol FeatureFactory: AnyObject {
    func makeView(for screenIdentifier: ScreenIdentifier) -> UIViewController
}

class FeatureFactoryImpl: FeatureFactory {
    
    func makeView(for screenIdentifier: ScreenIdentifier) -> UIViewController {
        switch screenIdentifier {
        case .splash:
            return makeSplashScreen()
        case .main:
            return makeMainScreen()
        case .itemDetails(let itemId):
            return makeItemDetailsScreen(itemId: itemId)
        }
    }
}

// MARK: - Supporting functions
extension FeatureFactoryImpl {
    
    private func makeSplashScreen() -> UIViewController {
        let storyboard = UIStoryboard(name: "LaunchScreen", bundle: .main)
        guard let splashVC = storyboard.instantiateInitialViewController() else {
            return UIViewController()
        }
        return splashVC
    }
    
    private func makeMainScreen() -> UIViewController {
        let itemsListVC = ItemsListViewController()
        let router: ItemsListViewRouting = ItemsListRouter(
            featureFactory: self,
            viewController: itemsListVC
        )
        let presenter = ItemsListPresenter(
            itemsListRepository: ItemsListRepositoryImpl(),
            router: router
        )
        presenter.input = itemsListVC
        itemsListVC.output = presenter
        
        let navController = UINavigationController(rootViewController: itemsListVC)
        navController.navigationBar.prefersLargeTitles = false
        itemsListVC.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        return navController
    }
    
    private func makeItemDetailsScreen(itemId: String?) -> UIViewController {
        let itemDetailsVC = ItemDetailsViewController()
        let router: ItemDetailsViewRouting = ItemDetailsRouter(
            featureFactory: self,
            viewController: itemDetailsVC
        )
        let presenter = ItemDetailsPresenter(
            itemId: itemId,
            itemDetailsRepository: ItemDetailsRepositoryImpl(),
            router: router
        )
        presenter.input = itemDetailsVC
        itemDetailsVC.output = presenter
        
        return itemDetailsVC
    }
    
}

