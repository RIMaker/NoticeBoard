//
//  NBViewControllerState.swift
//  NoticeBoard
//
//  Created by Zhora Agadzhanyan on 26.08.2023.
//

import Foundation

enum NBViewControllerState {
    case loading
    case error(
        error: NetworkError? = nil,
        onTap: (() -> Void)? = nil
    )
    case content
}
