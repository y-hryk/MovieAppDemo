//
//  LoadingView.swift
//  DEMO
//
//  Created by yamaguchi on 2016/04/19.
//  Copyright © 2016年 h.yamaguchi. All rights reserved.
//

import UIKit

class LoadingView: UIView {

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
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .White)
        activityIndicator.frame = CGRectMake(self.bounds.size.width / 2.0 - 55.0, self.bounds.size.height / 2.0 - 55.0, 110, 110)
        activityIndicator.startAnimating()
        self.addSubview(activityIndicator)
        
//        let indicatorWidth: CGFloat = 30
//        let indicatorWidth_half: CGFloat = indicatorWidth / 2.0
//        
//        let indicatorView = SpinningView(frame: CGRectMake(self.bounds.size.width / 2.0 - indicatorWidth_half,
//            self.bounds.size.height / 2.0 - indicatorWidth_half,
//            indicatorWidth,
//            indicatorWidth))
//        self.addSubview(indicatorView)
    }
}
