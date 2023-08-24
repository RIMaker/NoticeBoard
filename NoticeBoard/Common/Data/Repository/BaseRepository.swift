//
//  BaseRepository.swift
//  NoticeBoard
//
//  Created by Zhora Agadzhanyan on 25.08.2023.
//

import Foundation

class BaseRepository {
    
    lazy var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    lazy var encoder: JSONEncoder = {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        return encoder
    }()
    
}
