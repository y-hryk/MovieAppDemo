//
//  DiscoverRequest.swift
//  DEMO
//
//  Created by yamaguchi on 2016/05/16.
//  Copyright © 2016年 h.yamaguchi. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper

extension APIClient {
    
    class DiscoverRequest: Request {
        
        var method: Alamofire.Method = .GET
        var path: String {
            return "/discover/movie"
        }
        var query: String {
            return "?api_key=" + APIConfig.ACCESS_TOKEN + "&page=" + "\(self.page)" + "&sort_by=popularity.desc"
        }
        
        var page: Int = 1
        
        typealias Response = DisCover
        
        func convertJSONObject(object: AnyObject) -> Response? {
            var discover : DisCover?
            
            if let map = Mapper<DisCover>().map(object) {
                discover = map
            }
            
            return discover
        }
    }
    
}
