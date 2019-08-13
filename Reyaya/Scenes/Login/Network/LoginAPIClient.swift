//
//  LoginAPIClient.swift
//  Reyaya
//
//  Created by Peter Bassem on 7/30/19.
//  Copyright © 2019 Peter Bassem. All rights reserved.
//

import Foundation
import PromisedFuture

class LoginAPIClient {
    
    static func login(email: String, password: String) -> Future<LoginModel> {
        return APIClient.performRequest(route: LoginEndPoint.login(email: email, password: password))
    }
}
