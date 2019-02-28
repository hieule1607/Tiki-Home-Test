//
//  ApiClient.swift
//  TikiHomeTest
//
//  Created by Hieu Lam on 2/28/19.
//  Copyright © 2019 Hieu Lam. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class ApiClient {
    public static let shared = ApiClient()
    func request(urlRequest: URLRequestConvertible, completion: @escaping (JSON?) -> Void) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        Alamofire.request(urlRequest).responseJSON { (response) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            guard response.result.isSuccess, let value = response.result.value else {
                print("Error while fetching: \(String(describing: response.result.error))")
                completion(nil)
                return
            }
            
            completion(JSON(value))
        }
    }
}
