//
//  ApiPath.swift
//  TikiHomeTest
//
//  Created by Hieu Lam on 2/27/19.
//  Copyright © 2019 Hieu Lam. All rights reserved.
//

import Foundation
import Alamofire

public enum APIRouter: URLRequestConvertible {
    
    // 1
    enum Constants {
        static let baseURLPath = "https://tiki-mobile.s3-ap-southeast-1.amazonaws.com/ios"
        static let authenticationToken = ""
    }
    
    // 2
    case keywords
    
    // 3
    var method: HTTPMethod {
        switch self {
        case .keywords:
            return .get
        }
    }
    
    // 4
    var path: String {
        switch self {
        case .keywords:
            return "/keywords.json"
        }
    }
    
    // 5
    var parameters: [String: Any] {
        switch self {
        case .keywords:
            return [:]
        }
    }
    
    // 6
    public func asURLRequest() throws -> URLRequest {
        let url = try Constants.baseURLPath.asURL()
        
        var request = URLRequest(url: url.appendingPathComponent(path))
        request.httpMethod = method.rawValue
        request.setValue(Constants.authenticationToken, forHTTPHeaderField: "Authorization")
        request.timeoutInterval = TimeInterval(10 * 1000)
        
        return try URLEncoding.default.encode(request, with: parameters)
    }
}
