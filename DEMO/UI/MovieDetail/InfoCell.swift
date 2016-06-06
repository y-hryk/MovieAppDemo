//
//  MovieInfoCell.swift
//  DEMO
//
//  Created by yamaguchi on 2016/04/23.
//  Copyright © 2016年 h.yamaguchi. All rights reserved.
//

import UIKit

class InfoCell: UITableViewCell {
    
    static let height: CGFloat = 90
    private let margin : CGFloat = 10.0
    
    private var titleLabel: UILabel!
    private var rateLabel: UILabel!
    private var genreLabel: UILabel!

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
        self.backgroundColor = UIColor.clearColor()
        let width: CGFloat = UIScreen.mainScreen().bounds.size.width
        
        self.titleLabel = UILabel(frame: CGRectMake(self.margin, 0, width - (self.margin * 2), 40))
        self.titleLabel.backgroundColor = UIColor.clearColor()
//        self.titleLabel.text = "Star Wars: The Force Awakens"
        self.titleLabel.textColor = UIColor.mainTextColor()
        self.titleLabel.font = UIFont.appFont(size: 20)
        self.titleLabel.lineBreakMode = .ByTruncatingTail
        self.contentView.addSubview(self.titleLabel)
        
        let titleLabelBottom: CGFloat = self.titleLabel.frame.origin.y + self.titleLabel.frame.size.height
        
        let starImage = UIImageView(frame: CGRectMake(self.margin, titleLabelBottom, 16.5, 17))
        starImage.image = UIImage(named: "products_star")
        self.contentView.addSubview(starImage)
        
        self.rateLabel = UILabel(frame: CGRectMake(starImage.frame.origin.x + starImage.frame.size.width + self.margin, titleLabelBottom, 200, 17))
        self.rateLabel.backgroundColor = UIColor.clearColor()
//        self.rateLabel.text = "7.6 (3,826 votes)"
        self.rateLabel.textColor = UIColor.mainTextColor()
        self.rateLabel.font = UIFont.appFont(size: 18)
        self.contentView.addSubview(self.rateLabel)
        
        let rateLabelBottom: CGFloat = rateLabel.frame.origin.y + rateLabel.frame.size.height
        self.genreLabel = UILabel(frame: CGRectMake(margin, rateLabelBottom, width - (margin * 2), 40))
        self.genreLabel.backgroundColor = UIColor.clearColor()
//        self.genreLabel.text = "Science Fiction,Adventure,Thriller"
        self.genreLabel.textColor = UIColor.mainTextColor()
        self.genreLabel.font = UIFont.appFont(size: 12)
        self.genreLabel.lineBreakMode = .ByTruncatingTail
        self.contentView.addSubview(self.genreLabel)
    }
    
    func setRowData(data: Movie?, indexPath: NSIndexPath) {
        guard let data = data else {
            return
        }
        self.titleLabel.text = data.original_title
        self.rateLabel.text = "\(data.vote_average) " + "(\(data.vote_count) votes)"
        
        let genre = data.genres.reduce("") { $0 + $1 + "," }
        
//        let genre = data.genres.reduce("") { (text, currentText) -> String in
//            return text + currentText + ","
//        }

        self.genreLabel.text = genre
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
