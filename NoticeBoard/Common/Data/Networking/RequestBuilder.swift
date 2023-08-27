//
//  RequestBuilder.swift
//  NoticeBoard
//
//  Created by Zhora Agadzhanyan on 26.08.2023.
//

import Foundation

protocol RequestBuilderContract: AnyObject {
    func build(request: any NetworkRequestContract) -> Result<URLRequest, NetworkError>
}

final class RequestBuilderImpl: RequestBuilderContract {
    
    private let host: String
    
    init(host: String = "www.avito.st") {
        self.host = host
    }
    
    func build(request: any NetworkRequestContract) -> Result<URLRequest, NetworkError> {
        guard let url = URL(string: "https://\(host)/\(request.path)") else {
            return .failure(.cantBuildUrlFromRequest)
        }
        
        var urlRequest = URLRequest(url: url, timeoutInterval: 15)
        urlRequest.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        urlRequest.httpMethod = request.httpMethod.rawValue
        urlRequest.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        
        return .success(urlRequest)
    }
}
