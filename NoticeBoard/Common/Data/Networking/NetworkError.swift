//
//  NetworkError.swift
//  NoticeBoard
//
//  Created by Zhora Agadzhanyan on 26.08.2023.
//

import Foundation

enum NetworkError: Error {
    case cantBuildUrlFromRequest
    case noInternetConnection
    case noData
    case parsingFailure
    case networkError
    case timedOut
}
