//
//  NetworkClient.swift
//  NoticeBoard
//
//  Created by Zhora Agadzhanyan on 25.08.2023.
//

import Foundation

protocol NetworkClientContract: AnyObject {
    func send<Request: NetworkRequestContract>(
        request: Request,
        completion: @escaping (Result<Request.Response, NetworkError>) -> Void
    )
}

class NetworkClientImpl: NetworkClientContract {
    
    private let session: URLSession = URLSession.shared
    
    private let requestBuilder: RequestBuilderContract
    
    init(requestBuilder: RequestBuilderContract = RequestBuilderImpl()) {
        self.requestBuilder = requestBuilder
    }
    
    func send<Request: NetworkRequestContract>(
        request: Request,
        completion: @escaping (Result<Request.Response, NetworkError>) -> Void
    ) {
        
        switch requestBuilder.build(request: request) {
        case let .success(urlRequest):
            send(
                urlRequest: urlRequest,
                responseConverter: request.responseConverter
            ) { result in
                switch result {
                case .success(let response):
                    completion(.success(response))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
            
        case let .failure(error):
            completion(.failure(error))
            
        }
    }
    
    private func send<Converter: NetworkResponseConverterContract>(
        urlRequest: URLRequest,
        responseConverter: Converter,
        completion: @escaping (Result<Converter.Response, NetworkError>) -> Void
    ) {
        session.dataTask(with: urlRequest) { [weak self] (data, response, error) in
            
            if let error {
                switch (error as? URLError)?.code {
                case .some(.notConnectedToInternet):
                    completion(.failure(.noInternetConnection))
                case .some(.timedOut):
                    completion(.failure(.timedOut))
                default:
                    completion(.failure(.networkError))
                }
                return
            }
            if let httpStatus = response as? HTTPURLResponse, !(200...299).contains(httpStatus.statusCode) {
                completion(.failure(.networkError))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            self?.decodeResponse(from: data, responseConverter: responseConverter, completion: completion)
            
        }.resume()
    }
    
    private func decodeResponse<Converter: NetworkResponseConverterContract>(
        from data: Data,
        responseConverter: Converter,
        completion: @escaping (Result<Converter.Response, NetworkError>) -> Void
    ) {
        if let response = responseConverter.decodeResponse(from: data) {
            completion(.success(response))
            return
        }
        completion(.failure(.parsingFailure))
    }
    
}
