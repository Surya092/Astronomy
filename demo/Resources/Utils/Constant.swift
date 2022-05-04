//
//  Constant.swift
//  demo
//
//  Created by Surya on 02/05/22.
//

import Foundation

class Constant {
    
    //
    enum DataIdentifier: String {
        case apiData
    }

    //Subscription Key
    enum SharedResource: String {
        case apiSubscriptionKey = "nDhAlz8jGU1lh42nvVGdbdhi0IrvcZn3bIYHkQxF"
    }
    
    //Request Header Keys
    enum RequestHeaderKeys: String {
        case apiKey = "api_key"
    }
    
}

class UserDefaultStorage {
    
    class func fetchObjectForKey(key: String) -> Data? {
        return UserDefaults.standard.object(forKey: key) as? Data
    }
    
    class func setCodableObjectForKey<T: Codable>(value: T?, key: String) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(value) {
            UserDefaults.standard.set(encoded, forKey: key)
        }
    }
    
}
