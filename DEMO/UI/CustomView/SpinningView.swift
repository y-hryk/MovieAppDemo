//
//  SpinningView.swift
//  DEMO
//
//  Created by yamaguchi on 2016/05/12.
//  Copyright © 2016年 h.yamaguchi. All rights reserved.
//

import UIKit

class SpinningView: UIView {
    
    let circleLayer = CAShapeLayer()

    let strokeEndAnimation: CAAnimation = {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = 2
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        
        let group = CAAnimationGroup()
        group.duration = 2.5
        group.repeatCount = MAXFLOAT
        group.animations = [animation]
        
        return group
    }()
    
    let strokeStartAnimation: CAAnimation = {
        let animation = CABasicAnimation(keyPath: "strokeStart")
        animation.beginTime = 0.5
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = 2
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        
        let group = CAAnimationGroup()
        group.duration = 2.5
        group.repeatCount = MAXFLOAT
        group.animations = [animation]
        
        return group
    }()
    
    let rotationAnimation: CAAnimation = {
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        animation.fromValue = 0
        animation.toValue = M_PI * 2
        animation.duration = 4
        animation.repeatCount = MAXFLOAT
        return animation
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let center = CGPoint(x: self.bounds.midX, y: self.bounds.midY)
        let radius = min(self.bounds.width, self.bounds.height) / 2 - circleLayer.lineWidth/2
        
        let startAngle = CGFloat(-M_PI_2)
        let endAngle = startAngle + CGFloat(M_PI * 2)
        let path = UIBezierPath(arcCenter: CGPointZero, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        
        circleLayer.position = center
        circleLayer.path = path.CGPath
    }
    
    func setup() {
        circleLayer.lineWidth = 2
        circleLayer.fillColor = nil
        circleLayer.strokeColor = UIColor(red: 0.8078, green: 0.2549, blue: 0.2392, alpha: 1.0).CGColor
        circleLayer.strokeColor = UIColor.whiteColor().CGColor
        layer.addSublayer(circleLayer)
        
        updateAnimation()
    }
    
    func updateAnimation() {
        circleLayer.addAnimation(strokeEndAnimation, forKey: "strokeEnd")
        circleLayer.addAnimation(strokeStartAnimation, forKey: "strokeStart")
        circleLayer.addAnimation(rotationAnimation, forKey: "rotation")
    }
}

