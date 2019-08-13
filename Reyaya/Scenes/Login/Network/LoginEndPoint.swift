//
//  LoginEndPoint.swift
//  Reyaya
//
//  Created by Peter Bassem on 7/30/19.
//  Copyright © 2019 Peter Bassem. All rights reserved.
//

import Foundation
import Alamofire

enum LoginEndPoint: APIConfiguration {
    
    case login(email:String, password:String)
    
    //MARK: - HTTPMethod
    var method: HTTPMethod {
        switch self {
        case LoginEndPoint.login:
            return HTTPMethod.post
        }
    }
    
    //MARK: - Path
    var path: String {
        switch self {
        case LoginEndPoint.login:
            return "/login"
        }
    }
    
    //MARK: - Parameters
    var parameters: Parameters? {
        switch self {
        case LoginEndPoint.login(let email, let password):
            return [K.APIParameterKey.Login.email: email, K.APIParameterKey.Login.password: password]
        }
    }
    
    //MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        let url = try K.ProductionServer.baseURL.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        // HTTP Method
        urlRequest.httpMethod = method.rawValue
        
        // Common Headers
        urlRequest.setValue(K.ContentType.json.rawValue, forHTTPHeaderField: K.HTTPHeaderField.acceptType.rawValue)
        urlRequest.setValue(K.ContentType.json.rawValue, forHTTPHeaderField: K.HTTPHeaderField.contentType.rawValue)
        
        // Parameters
        if let parameters = parameters {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }
        
        return urlRequest
    }
}
