//
//  Font.swift
//  DEMO
//
//  Created by yamaguchi on 2016/05/12.
//  Copyright © 2016年 h.yamaguchi. All rights reserved.
//

import UIKit

extension UIFont {
    
    class func appFont(size size: CGFloat) -> UIFont {
        return UIFont(name: "Futura-Medium", size: size)!
    }
    
    class func appBoldFont(size size: CGFloat) -> UIFont {
        return UIFont(name: "Futura-CondensedMedium", size: size)!
    }

}
