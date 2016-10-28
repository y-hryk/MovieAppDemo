//
//  Cast.swift
//  DEMO
//
//  Created by yamaguchi on 2016/04/28.
//  Copyright © 2016年 h.yamaguchi. All rights reserved.
//

import UIKit
import ObjectMapper

class Cast: Mappable {

    var cast_id = ""
    var character = ""
    var credit_id = ""
    var name = ""
    var order = 0
    var profile_path = ""
    
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        cast_id         <- map["cast_id"]
        character       <- map["character"]
        credit_id       <- map["credit_id"]
        name            <- map["name"]
        order           <- map["order"]
        profile_path    <- map["profile_path"]
    }

}
