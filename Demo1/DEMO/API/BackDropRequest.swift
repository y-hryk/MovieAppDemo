//
//  BackDropRequest.swift
//  DEMO
//
//  Created by yamaguchi on 2016/05/16.
//  Copyright © 2016年 h.yamaguchi. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper

extension APIClient {
    
    class BackDropRequest: Request {
        /*
        * エンドポイント
        * http://api.themoviedb.org/3/movie/209112/images?api_key=328c283cd27bd1877d9080ccb1604c91
        */
        
        var method : Alamofire.Method = .GET
        var path: String {
            return "/movie/" + "\(self.movieId)" + "/images"
        }
        var query: String {
            return "?api_key=" + APIConfig.ACCESS_TOKEN
        }
        
        var movieId: NSInteger = 0
        
        typealias Response = [Backdrop]
        
        func convertJSONObject(object: AnyObject) -> Response? {
            var backdrops = [Backdrop]?()
            
            if let array = object["backdrops"] {
                backdrops = Mapper<Backdrop>().mapArray(array)
            }
            
            return backdrops
        }
    }

}