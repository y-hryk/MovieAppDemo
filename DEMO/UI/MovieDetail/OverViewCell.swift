//
//  MovieOverViewCell.swift
//  DEMO
//
//  Created by yamaguchi on 2016/04/28.
//  Copyright © 2016年 h.yamaguchi. All rights reserved.
//

import UIKit

class OverViewCell: UITableViewCell {

    static let height: CGFloat = 120
    
    private let margin : CGFloat = 10.0
    private var titleLabel: UILabel!
    private var overViewLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        self.selectionStyle = .None
        backgroundColor = UIColor.clearColor()
        let width: CGFloat = UIScreen.mainScreen().bounds.size.width
        
        self.titleLabel = UILabel(frame: CGRectMake(self.margin, 0, width - (self.margin * 2), 20))
        self.titleLabel.backgroundColor = UIColor.clearColor()
        self.titleLabel.text = "OverView"
        self.titleLabel.textColor = UIColor.subTextColor()
        self.titleLabel.font = UIFont.appFont(size: 13)
        self.contentView.addSubview(self.titleLabel)
        
        let titleLabelBottom: CGFloat = self.titleLabel.frame.origin.y + self.titleLabel.frame.size.height
        self.overViewLabel = UILabel(frame: CGRectMake(self.margin, titleLabelBottom, width - (self.margin * 2), 100))
        self.overViewLabel.backgroundColor = UIColor.clearColor()
        self.overViewLabel.text = "Thirty years after defeating the Galactic Empire, Han Solo and his allies face a new threat from the evil Kylo Ren and his army of Stormtroopers."
        self.overViewLabel.textColor = UIColor.mainTextColor()
        self.overViewLabel.font = UIFont.appFont(size: 14)
        self.overViewLabel.numberOfLines = 0
        self.overViewLabel.lineBreakMode = .ByTruncatingTail
        self.contentView.addSubview(self.overViewLabel)
    }
    
    func setRowData(data: Movie?, indexPath: NSIndexPath) {
        guard let data = data else {
            return
        }
        
        self.overViewLabel.text = data.overview
    }
    
}
