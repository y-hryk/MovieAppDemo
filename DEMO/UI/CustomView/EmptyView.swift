//
//  EmptyView.swift
//  DEMO
//
//  Created by yamaguchi on 2016/04/19.
//  Copyright © 2016年 h.yamaguchi. All rights reserved.
//

import UIKit

class EmptyView: UIView {
    
    var label: UILabel!
    var button: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = frame
        self.setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        self.backgroundColor = UIColor.clearColor()
        
        self.label = UILabel()
        self.label.frame = CGRectMake((self.frame.size.width / 2) - (200 / 2), (self.frame.height / 2) - (20 / 2), 200, 30)
        self.label.textColor = UIColor.whiteColor()
        self.label.textAlignment = .Center
        self.label.backgroundColor = UIColor.clearColor()
        self.label.text = "No Contents"
        self.label.font = UIFont.appFont(size: 18)
        self.addSubview(self.label)
        
        let bottom: CGFloat = self.label.frame.origin.y + self.label.frame.height
        
        self.button = UIButton(type: .RoundedRect)
        self.button.frame = CGRectMake((self.frame.size.width / 2) - (140 / 2), bottom, 140, 40)
        self.button.backgroundColor = UIColor.lightGrayColor()
        self.button.setTitle("Retry", forState: .Normal)
        self.button.titleLabel!.font = UIFont.appFont(size: 18)
        self.button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        self.button.layer.cornerRadius = 6.0
        self.addSubview(self.button)
    }

}
