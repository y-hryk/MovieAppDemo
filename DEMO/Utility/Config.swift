//
//  Config.swift
//  DEMO
//
//  Created by yamaguchi on 2016/05/13.
//  Copyright © 2016年 h.yamaguchi. All rights reserved.
//

import UIKit

func LOG(obj: AnyObject?, function: String = __FUNCTION__, line: Int = __LINE__) {
    //#if DEBUG
    guard let unwrapped_obj = obj else {
        print("[Function:\(function) Line:\(line)] : ")
        return
    }
    print("[Function:\(function) Line:\(line)] : \(unwrapped_obj)")
    //#endif
}
