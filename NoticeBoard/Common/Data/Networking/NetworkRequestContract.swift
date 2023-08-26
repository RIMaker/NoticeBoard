//
//  NetworkRequest.swift
//  NoticeBoard
//
//  Created by Zhora Agadzhanyan on 26.08.2023.
//

import Foundation

protocol NetworkRequestContract {
    associatedtype Response
    
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var responseConverter: NetworkResponseConverterOf<Response> { get }
}

extension NetworkRequestContract where Response: Decodable {
    var responseConverter: NetworkResponseConverterOf<Response> {
        NetworkResponseConverterOf(converter: DecodingNetworkResponseConverterImpl())
    }
}
