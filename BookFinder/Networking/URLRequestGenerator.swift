//
//  URLRequestGenerator.swift
//  BookFinder
//
//  Created by Smriti Rana on 13/12/22.
//

import Foundation

protocol URLRequestGeneratorProtocol {
    func createURLRequest(using endPoint: NetworkRequestProtocol) throws -> URLRequest
}

class URLRequestGenerator: URLRequestGeneratorProtocol {
        
    func createURLRequest(using endPoint: NetworkRequestProtocol) throws -> URLRequest {
        do {
            let url = try createURL(with: endPoint)
            
            var urlRequest = URLRequest(url: url,
                                        cachePolicy: .useProtocolCachePolicy,
                                        timeoutInterval: 10.0)
    
            urlRequest.httpMethod = endPoint.method.rawValue
            
            if !endPoint.bodyParamaters.isEmpty {
                let bodyData = try? JSONSerialization.data(withJSONObject: endPoint.bodyParamaters, options: [.prettyPrinted])
                urlRequest.httpBody = bodyData
            }
            
            endPoint.headerParamaters.forEach({ key, value in
                urlRequest.setValue(value, forHTTPHeaderField: key)
            })
            
            return urlRequest
        } catch {
            throw error
        }
    }
    
    private func createURL(with endPoint: NetworkRequestProtocol) throws -> URL {
        var components = URLComponents()
        components.scheme = Configuration.scheme
        components.host = Configuration.host
        components.path = endPoint.path
        components.queryItems = endPoint.queryParameters.map {
            URLQueryItem(name: $0, value: "\($1)")
        }
        
        guard let url = components.url else {
            throw NSError(domain: Configuration.url, code: NSURLErrorBadURL, userInfo: nil)
        }
        return url
    }
}
