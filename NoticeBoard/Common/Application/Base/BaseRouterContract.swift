//
//  BaseRouterContract.swift
//  NoticeBoard
//
//  Created by Zhora Agadzhanyan on 24.08.2023.
//

import Foundation

@MainActor protocol BaseRouterContract: AnyObject {
    func route(to screenId: ScreenIdentifier)
    func dismiss()
}
