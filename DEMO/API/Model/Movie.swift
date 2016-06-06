//
//  Movie.swift
//  DEMO
//
//  Created by yamaguchi on 2016/04/05.
//  Copyright © 2016年 h.yamaguchi. All rights reserved.
//

import UIKit
import ObjectMapper

class Movie: Mappable {
    
    var movieId = 0
    var original_title = ""
    var imagePath = ""
    var overview = ""
    var release_date = ""
    var backdrop_path = ""
    var vote_average = 0.0
    var vote_count = 0
    var genres = [String]()
    
    required init?(_ map: Map) {
    
    }
    
    func mapping(map: Map) {
        movieId             <- map["id"]
        original_title      <- map["original_title"]
        imagePath           <- map["backdrop_path"]
        overview            <- map["overview"]
        release_date        <- map["release_date"]
        backdrop_path       <- map["backdrop_path"]
        vote_average        <- map["vote_average"]
        vote_count          <- map["vote_count"]
        
        // Detail Info
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
