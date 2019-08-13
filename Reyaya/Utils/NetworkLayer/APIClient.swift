//
//  APIClient.swift
//  ElNabawy Cars
//
//  Created by Peter Bassem on 6/11/19.
//  Copyright © 2019 Peter Bassem. All rights reserved.
//

import Foundation
import Alamofire
import PromisedFuture

class APIClient {
    
    //MARK: - peroformRequest without Future
    //    @discardableResult
    //    static func performRequest<T:Decodable>(route:APIConfiguration, decoder: JSONDecoder = JSONDecoder(), completion:@escaping (Result<T, Error>)->Void) -> DataRequest {
    //        return AF.request(route)
    //            .responseDecodable (decoder: decoder){ (response: DataResponse<T>) in
    //                completion(response.result)
    //        }
    //    }
    
    //MARK: - peroformRequest with Future
    @discardableResult
    static func performRequest<T:Decodable>(route: APIConfiguration, decoder: JSONDecoder = JSONDecoder()) -> Future<T> {
        return Future(operation: { (completion) in
            AF.request(route).responseDecodable(decoder: decoder, completionHandler: { (response: DataResponse<T>) in
                switch response.result {
                case .success(let value):
                    completion(.success(value))
                case .failure(let error):
                    completion(.failure(error))
                }
            })
        })
        
    }
}
