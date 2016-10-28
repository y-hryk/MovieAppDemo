//
//  MoreLoadView.swift
//  DEMO
//
//  Created by yamaguchi on 2016/06/06.
//  Copyright © 2016年 h.yamaguchi. All rights reserved.
//

import UIKit

class MoreLoadView: UIView {
    
    var indicator: UIActivityIndicatorView!

    init() {
        super.init(frame: CGRectZero)
        self.setupViews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Private
    private func setupViews() {
        
        self.indicator = UIActivityIndicatorView(activityIndicatorStyle: .White)
        self.addSubview(indicator)
        self.indicator.hidden = true
    }

    // MARK: Public
    func showIndicator() {
        self.indicator.hidden = false
        self.indicator.alpha = 0.0
        self.indicator.startAnimating()
        
        UIView.animateWithDuration(0.35, delay: 0.0, options: .CurveEaseInOut,
                                   animations: {
                                    
                                    self.indicator.alpha = 1.0
                                    
        }) { (finished) in
            self.indicator.hidden = false
        }
    }
    
    func hideIndicator() {
        self.indicator.hidden = false
        self.indicator.alpha = 1.0
        self.indicator.stopAnimating()
        
        UIView.animateWithDuration(0.35, delay: 0.0, options: .CurveEaseInOut,
                                   animations: {
                                    
                                    self.indicator.alpha = 0.0
                                    
        }) { (finished) in
            self.indicator.hidden = true
        }
    }
    
    // MARK: OverRide
    override func layoutSubviews() {
        super.layoutSubviews()
        self.indicator.frame = CGRectMake(self.bounds.size.width / 2.0 - 55.0, self.bounds.size.height / 2.0 - 55.0, 110, 110)
    }
}
