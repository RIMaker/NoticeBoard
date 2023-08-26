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
        
        return navController
    }
    
}

