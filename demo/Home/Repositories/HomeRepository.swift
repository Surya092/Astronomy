//
//  HomeRepository.swift
//  demo
//
//  Created by Surya on 04/05/22.
//

import Foundation

import UIKit

struct HomeRepository {
    static let shared = HomeRepository()
    private init() {}
    
    //MARK: API call and sync Logic
    func fetchImageAPIData(completionHandler: @escaping (Result<HomeAPIResponse, TaskError>) -> Void) {
        let task = HTTPTask()
        task.GET(api: UserAPI.nasaImageApi) { (result: Result<HomeAPIResponse, TaskError>) -> Void in
            DispatchQueue.main.async {
                completionHandler(result)
            }
        }
    }
    
}

// MARK: - API Response
struct HomeAPIResponse: Codable {
    var copyright: String?
    var date: String?
    var explanation: String?
    var hdurl: String?
    var mediaType: String?
    var serviceVersion: String?
    var title: String?
    var url: String?
}
