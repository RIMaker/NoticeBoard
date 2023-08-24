//
//  BaseRouterContract.swift
//  NoticeBoard
//
//  Created by Zhora Agadzhanyan on 24.08.2023.
//

import Foundation

protocol BaseRouterContract {
    func route(to screenId: ScreenIdentifier)
    func dismiss()
    func showAlert(title: String?, message: String?)
    func showActivityIndicator()
    func hideActivityIndicator()
}
