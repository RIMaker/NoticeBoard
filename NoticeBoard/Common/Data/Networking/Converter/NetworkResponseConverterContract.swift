//
//  NetworkResponseConverterContract.swift
//  NoticeBoard
//
//  Created by Zhora Agadzhanyan on 26.08.2023.
//

import Foundation

protocol NetworkResponseConverterContract: AnyObject {
    associatedtype Response
    
    func decodeResponse(from data: Data) -> Response?
}
