//
//  ItemDetailsRouter.swift
//  NoticeBoard
//
//  Created by Zhora Agadzhanyan on 24.08.2023.
//

import UIKit

final class ItemDetailsRouter: BaseRouter, ItemDetailsViewRouting {
    
    func openUrl(_ url: URL) {
        UIApplication.shared.open(url)
    }
    
}
