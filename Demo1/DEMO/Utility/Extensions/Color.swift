//
//  Color.swift
//  DEMO
//
//  Created by yamaguchi on 2016/04/14.
//  Copyright © 2016年 h.yamaguchi. All rights reserved.
//

import UIKit

public enum GradientType:  NSInteger {
    case angle0
    case angle45
    case angle90
}

extension UIColor {
    
    class func RGBA(r : Int, _ g : Int, _ b : Int, _ alpha : CGFloat) -> UIColor {
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(alpha))
    }
    
    class func RGB(r : Int, _ g : Int, _ b : Int) -> UIColor {
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(1.0))
    }
    
    class func gradientStartColor(startColor: UIColor, endColor: UIColor, view: UIView, type: GradientType) {
        
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.colors = [startColor.CGColor, endColor.CGColor]
        
        var startPoint: CGPoint = CGPointZero
        var endPoint: CGPoint = CGPointZero
        
        switch type {
        case .angle0:
            startPoint = CGPointMake(0.5, 0.0);
            endPoint = CGPointMake(0.5, 1.0);
        case .angle45:
            startPoint = CGPointMake(1.0, 0.0);
            endPoint = CGPointMake(0.0, 1.0);
        case .angle90:
            startPoint = CGPointMake(1.0, 0.5);
            endPoint = CGPointMake(0.0, 0.5);
        }
        
        gradientLayer.frame = view.bounds
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        view.layer.insertSublayer(gradientLayer, atIndex: 0)
    }
    
    class func baseColor() -> UIColor {
        return UIColor.RGB(33, 33, 33)
    }
    class func mainTextColor() -> UIColor {
        return UIColor.RGB(243, 243, 243)
    }
    class func subTextColor() -> UIColor {
        return UIColor.RGB(135, 135, 135)
    }
    class func imagePlaceholderColor() -> UIColor {
        return UIColor.RGB(35, 35, 35)
    }
    class func accentColor() -> UIColor {
        return UIColor.RGB(188, 94, 93)
    }

}