//
//  Discover.swift
//  DEMO
//
//  Created by yamaguchi on 2016/04/26.
//  Copyright © 2016年 h.yamaguchi. All rights reserved.
//

import Foundation
import ObjectMapper

class DisCover: Mappable {
    
    var page = 0
    var results = [Movie]()
    var totalPages = 0
    var totalResults = 0
    
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        page <- map["page"]
        totalPages <- map["total_pages"]
        totalResults <- map["total_results"]
        
        if let map = Mapper<Movie>().mapArray(map.JSONDictionary["results"]) {
            results = map
        }
    }
}
