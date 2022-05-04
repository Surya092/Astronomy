//
//  UserAPI.swift
//  demo
//
//  Created by Surya on 02/05/22.
//

import Foundation

protocol URLComponentsRepresentable {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var queryItems: [URLQueryItem]? {get}
}

extension URLComponentsRepresentable {
    var urlComponents: URLComponents {
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = host
        urlComponents.path = path
        urlComponents.queryItems = queryItems
        return urlComponents
    }
    
    var url: URL? {
        return urlComponents.url
    }
}

enum UserAPI {
    case nasaImageApi
}

extension UserAPI: URLComponentsRepresentable {

    var scheme: String {
        "https"
    }
    
    var host: String {
        "api.nasa.gov"
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .nasaImageApi:
            var queryParam: [URLQueryItem] = []
            queryParam.append(URLQueryItem(name: Constant.RequestHeaderKeys.apiKey.rawValue, value: Constant.SharedResource.apiSubscriptionKey.rawValue))
            return queryParam
        }
    }
    
    var path: String {
        switch self {
        case .nasaImageApi:
            return "/planetary/apod"
        
        }
    }
}

