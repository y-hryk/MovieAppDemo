//
//  Backdrop.swift
//  DEMO
//
//  Created by yamaguchi on 2016/04/28.
//  Copyright © 2016年 h.yamaguchi. All rights reserved.
//

import UIKit
import ObjectMapper

class Backdrop: Mappable {

    var aspect_ratio = 0.0
    var file_path = ""
    var width = 0
    var height = 0
    
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        aspect_ratio    <- map["aspect_ratio"]
        file_path       <- map["file_path"]
        width           <- map["width"]
        height          <- map["height"]
    }

}
