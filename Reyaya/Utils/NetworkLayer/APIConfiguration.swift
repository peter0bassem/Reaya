//
//  APIConfiguration.swift
//  ElNabawy Cars
//
//  Created by Peter Bassem on 6/11/19.
//  Copyright © 2019 Peter Bassem. All rights reserved.
//

import Foundation
import Alamofire

protocol APIConfiguration: URLRequestConvertible {
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: Parameters? { get }
}
