//
//  APIClient.swift
//  DEMO
//
//  Created by yamaguchi on 2016/04/05.
//  Copyright © 2016年 h.yamaguchi. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper

protocol Request {
    var method: Alamofire.Method { get }
    var path: String { get }
    var query: String { get }
    var paramters: [String: AnyObject]? { get }
    
    associatedtype Response: Any
    func convertJSONObject(object: AnyObject) -> Response?
}

// Default
extension Request {
    var query: String {
        return ""
    }
    var paramters: [String: AnyObject]? {
        return nil
    }
}

enum Response<T> {
    case Success(T)
    case Failure(NSError)
    
    init(_ value: T) {
        self = .Success(value)
    }
    
    init(_ error: NSError) {
        self = .Failure(error)
    }
}

class APIClient {
    
     func request<T: Request>(request: T, handler: (Response<T.Response>) -> Void) {
       // LOG("URL : \(request.path)")
        
        let URLString = APIConfig.BASE_DOMINE + request.path + request.query
        
        Alamofire.request(request.method, URLString, parameters: request.paramters).responseJSON { (response) -> Void in
        
            if let object = response.result.value {
                LOG("URL \(APIConfig.BASE_DOMINE)\(request.path)\n JSON : \(object)")
                if let responseModel = request.convertJSONObject(object) {
                    handler(Response(responseModel))
                    return
                }
            }
            
            if let error = response.result.error {
                LOG("URL \(request.path)\n ERROR : \(error.description)")
                handler(Response(error))
                return
            }
            
            let userInfo = [NSLocalizedDescriptionKey: "unresolved error occurred."]
            let error = NSError(domain: "WebAPIErrorDomain", code: 0, userInfo: userInfo)
            handler(Response(error))
        }
        
    }
}
