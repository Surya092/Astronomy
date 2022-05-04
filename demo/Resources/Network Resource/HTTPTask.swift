//
//  HTTPTask.swift
//  demo
//
//  Created by Surya on 02/05/22.
//

import Foundation
import UIKit

enum TaskError: Error {
    case jsonError
    case noData
    case other
}

enum Result<T, TaskError> {
    case success(T, Int?)
    case failure(TaskError, Int?)
}

enum ContentType: String {
    case json = "application/json"
    case text = "text/plain"
}

class HTTPTask: NSObject {
    
    func GET<T: Codable>(api: URLComponentsRepresentable,
                         config: URLSessionConfiguration? = nil,
                         completionHandler: @escaping (Result<T,TaskError>) -> Void ) {
        guard let url = api.url else {
            completionHandler(.failure(.other, nil))
            return
        }
        sendRequest(url, method: "GET", nil, completionHandler)
    }
    
    func POST<T: Codable, U: Codable>(api: URLComponentsRepresentable,
                                      jsonBody: U? = nil,
                                      contentType: ContentType = .json,
                                      config: URLSessionConfiguration? = nil,
                                      completionHandler: @escaping (Result<T,TaskError>) -> Void ) {
        guard let url = api.url else {
            completionHandler(.failure(.other, nil))
            return
        }
        var jsonBodyData: Data?
        if let body = jsonBody {
            let encoder = JSONEncoder()
            encoder.keyEncodingStrategy = .convertToSnakeCase
            let data = try? encoder.encode(body)
            jsonBodyData = data
        }
        sendRequest(url, method: "POST", jsonBodyData, contentType: contentType, completionHandler)
    }
    
    func PUT<T: Codable, U: Codable>(api: URLComponentsRepresentable, jsonBody: U? = nil, contentType: ContentType = .json, config: URLSessionConfiguration? = nil, completionHandler: @escaping (Result<T,TaskError>) -> Void ) {
        guard let url = api.url else {
            completionHandler(.failure(.other, nil))
            return
        }
        var jsonBodyData: Data?
        if let body = jsonBody {
            let encoder = JSONEncoder()
            encoder.keyEncodingStrategy = .convertToSnakeCase
            let data = try? encoder.encode(body)
            jsonBodyData = data
        }
        sendRequest(url, method: "PUT", jsonBodyData, contentType: contentType, completionHandler)
    }
    
    func UPDATE<T: Codable, U: Codable>(api: URLComponentsRepresentable, jsonBody: U? = nil, contentType: ContentType = .json, config: URLSessionConfiguration? = nil, completionHandler: @escaping (Result<T,TaskError>) -> Void ) {
        guard let url = api.url else {
            completionHandler(.failure(.other, nil))
            return
        }
        var jsonBodyData: Data?
        if let body = jsonBody {
            let encoder = JSONEncoder()
            encoder.keyEncodingStrategy = .convertToSnakeCase
            let data = try? encoder.encode(body)
            jsonBodyData = data
        }
        sendRequest(url, method: "PUT", jsonBodyData, contentType: contentType, completionHandler)
    }
    
    func DELETE<T: Codable>(api: URLComponentsRepresentable,
                            config: URLSessionConfiguration? = nil, completionHandler: @escaping (Result<T,TaskError>) -> Void ) {
        guard let url = api.url else {
            completionHandler(.failure(.other, nil))
            return
        }
        sendRequest(url, method: "DELETE", nil, completionHandler)
    }
    
    func sendRequest<T: Codable>(_ url: URL, method: String, _ data: Data?, contentType: ContentType = .json, sessionConfig: URLSessionConfiguration? = nil, _ completionHandler: @escaping (Result<T, TaskError>) -> Void) {
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method
        
        // Add Custom Headers for Request
        addCustomHeadersForRequest(&urlRequest)
        
        if let data = data {
            urlRequest.setValue(contentType.rawValue, forHTTPHeaderField: "Content-Type")
            urlRequest.httpBody = data
        }
        
        urlRequest.timeoutInterval = 120
        let session = URLSession.init(configuration: .ephemeral)
        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            
            let statusCode = (response as? HTTPURLResponse)?.statusCode
            
            if error != nil {
                completionHandler(.failure(.other, statusCode))
                return
            }
            
            guard let jsonData = data, !jsonData.isEmpty else {
                completionHandler(.failure(.noData, statusCode))
                return
            }
            
            let decoder = JSONDecoder()
            guard let jsonObject = try? decoder.decode(T.self, from: jsonData) else {
                completionHandler(.failure(.jsonError, statusCode))
                return
            }
            completionHandler(.success(jsonObject, statusCode))
            
        }
        task.resume()
    }
    
    //MARK: Request Header
    func addCustomHeadersForRequest(_ request: inout URLRequest) {
        
    }
    
}



