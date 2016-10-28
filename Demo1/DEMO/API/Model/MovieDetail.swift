//
//  MovieDetail.swift
//  DEMO
//
//  Created by yamaguchi on 2016/04/19.
//  Copyright © 2016年 h.yamaguchi. All rights reserved.
//

import UIKit
import ObjectMapper

class MovieDetail: Mappable {

    var movie: Movie?
    var genres = [String]()
    
    required init?(_ map: Map) {
    
    }
    
    func mapping(map: Map) {
        if let map = Mapper<Movie>().map(map) {
            movie = map
        }
        
        if let items = map.JSONDictionary["genres"] as? [AnyObject] {
            items.forEach({ (dict) in
                if let dict = dict as? NSDictionary {
                    if let videoId = dict.valueForKeyPath("name") as? String {
                        self.genres.append(videoId)
                    }
                }
            })
        }
    }
}
