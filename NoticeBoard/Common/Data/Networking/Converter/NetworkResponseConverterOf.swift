//
//  NetworkResponseConverterOf.swift
//  NoticeBoard
//
//  Created by Zhora Agadzhanyan on 26.08.2023.
//

import Foundation

final class NetworkResponseConverterOf<Response>: NetworkResponseConverterContract {
    
    private let decodeResponse: (Data) -> Response?
    
    init<Converter: NetworkResponseConverterContract>(
        converter: Converter
    ) where Converter.Response == Response {
        decodeResponse = { data in
            converter.decodeResponse(from: data)
        }
    }
    
    func decodeResponse(from data: Data) -> Response? {
        decodeResponse(data)
    }
}
