//
//  CastRequest.swift
//  DEMO
//
//  Created by yamaguchi on 2016/05/16.
//  Copyright © 2016年 h.yamaguchi. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper

extension APIClient {

    class CastRequest: Request {
        /*
        * エンドポイント
        * http://api.themoviedb.org/3/movie/209112/credits?api_key=328c283cd27bd1877d9080ccb1604c91
        */
        
        var method : Alamofire.Method = .GET
        var path: String {
            return "/movie/" + "\(self.movieId)" + "/credits"
        }
        var query: String {
            return "?api_key=" + APIConfig.ACCESS_TOKEN
        }

        var movieId: NSInteger = 0
        
        typealias Response = [Cast]
        
        func convertJSONObject(object: AnyObject) -> Response? {
            var casts = [Cast]?()
            
            if let array = object["cast"] {
                casts = Mapper<Cast>().mapArray(array)
            }
            
            return casts
        }
    }

}
