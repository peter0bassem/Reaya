//
//  NetworkConstants.swift
//  ElNabawy Cars
//
//  Created by Peter Bassem on 6/11/19.
//  Copyright © 2019 Peter Bassem. All rights reserved.
//

import Foundation

struct K {
    struct ProductionServer {
        static let baseURL = "https://reaya.xyz/api"
    }
    
    struct APIParameterKey {
        struct Login {
            static let password = "password"
            static let email = "username"
        }
    }
    
    enum HTTPHeaderField: String {
        case authentication = "Authorization"
        case contentType = "Content-Type"
        case acceptType = "Accept"
        case acceptEncoding = "Accept-Encoding"
    }
    
    enum ContentType: String {
        case json = "application/json"
    }
}
