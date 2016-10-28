//
//  MovieDetailRequest.swift
//  DEMO
//
//  Created by yamaguchi on 2016/05/16.
//  Copyright © 2016年 h.yamaguchi. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper

extension APIClient {
    
    class MovieDetailRequest: Request {
        /*
        * エンドポイント
        * http://api.themoviedb.org/3/movie/140607?api_key=328c283cd27bd1877d9080ccb1604c91
        */
        var method : Alamofire.Method = .GET
        var path: String {
            return "/movie/" + "\(self.movieId)"
            //            return "/movie/" + "\(self.movieId)" + "/credits" + "?api_key=" + Config.ACCESS_TOKEN
        }
        var query: String {
            return "?api_key=" + APIConfig.ACCESS_TOKEN
        }
        
        var movieId: NSInteger = 0
        
        typealias Response = Movie
        
        func convertJSONObject(object: AnyObject) -> Response? {
            var movieDetail : Movie?
            
            if let map = Mapper<Movie>().map(object) {
                movieDetail = map
            }
            
            return movieDetail
        }
    }

}
