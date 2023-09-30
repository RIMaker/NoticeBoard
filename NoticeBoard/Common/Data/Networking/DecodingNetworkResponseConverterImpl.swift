//
//  DecodingNetworkResponseConverterImpl.swift
//  NoticeBoard
//
//  Created by Zhora Agadzhanyan on 26.08.2023.
//

import Foundation

final class DecodingNetworkResponseConverterImpl<Response>: NetworkResponseConverterContract where Response: Decodable {
    
    private var decoder: JSONDecoder? = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .formatted(DateFormatter.yyyyMMdd)
        return decoder
    }()
    
    init(decoder: JSONDecoder? = nil) {
        if let decoder {
            self.decoder = decoder
        }
    }
    
    func decodeResponse(from data: Data) -> Response? {
        try? decoder?.decode(Response.self, from: data)
    }
}
