//
//  BaseRouter.swift
//  NoticeBoard
//
//  Created by Zhora Agadzhanyan on 24.08.2023.
//

import UIKit

class BaseRouter: NSObject, BaseRouterContract {
    
    var featureFactory: FeatureFactory
    weak var viewController: UIViewController?
    
    init(featureFactory: FeatureFactory, viewController: UIViewController) {
        self.featureFactory = featureFactory
        self.viewController = viewController
    }
    
    func route(to screenId: ScreenIdentifier) {
        let destination = featureFactory.makeView(for: screenId)
        guard let navVC = viewController?.navigationController else {
            viewController?.present(destination, animated: true)
            return
        }
        navVC.pushViewController(destination, animated: true)
    }
    
    func dismiss() {
        guard let navVC = viewController?.navigationController else {
            viewController?.dismiss(animated: true)
            return
        }
        navVC.popViewController(animated: true)
    }
    
}



