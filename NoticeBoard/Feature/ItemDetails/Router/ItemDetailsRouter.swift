//
//  ItemDetailsRouter.swift
//  NoticeBoard
//
//  Created by Zhora Agadzhanyan on 24.08.2023.
//

import UIKit

final class ItemDetailsRouter: BaseRouter, ItemDetailsViewRouting {
    
    func openUrl(fromPath path: String) {
        if let url = URL(string: path), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        } else {
            self.viewController?.state = .error(error: .cantBuildUrlFromRequest)
        }
    }
    
}
