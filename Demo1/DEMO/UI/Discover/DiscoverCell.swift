//
//  DiscoverCell.swift
//  DEMO
//
//  Created by yamaguchi on 2016/04/14.
//  Copyright © 2016年 h.yamaguchi. All rights reserved.
//

import UIKit
import Kingfisher

class DiscoverCell: UICollectionViewCell {
    
    static let width: CGFloat = UIScreen.mainScreen().bounds.size.width
    static let height: CGFloat = (DiscoverCell.width * 9) / 16
    
    private let labelMargin : CGFloat = 10.0
    private var thumbnailImage: UIImageView!
    private var titleLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViews()
    }
    
    func setupViews() {
        self.thumbnailImage = UIImageView()
        self.thumbnailImage.frame = CGRectMake(0, 0, self.contentView.frame.width, self.contentView.frame.height)
        self.thumbnailImage.backgroundColor = UIColor.imagePlaceholderColor()
        self.thumbnailImage.contentMode = .ScaleAspectFill
        self.thumbnailImage.clipsToBounds = true
        self.contentView.addSubview(self.thumbnailImage)
        
        let gradientView = UIView(frame: CGRectMake(0, self.contentView.frame.height - 50, self.contentView.frame.width, 50))
        UIColor.gradientStartColor(UIColor.RGBA(0, 0, 0, 0.0),
                                   endColor: UIColor.RGBA(0, 0, 0, 0.7),
                                   view: gradientView,
                                   type: .angle0)
        self.contentView.addSubview(gradientView)
        
        self.titleLabel = UILabel(frame: CGRectMake(self.labelMargin, self.contentView.frame.height - 50, self.contentView.frame.width - (self.labelMargin * 2), 50))
        self.titleLabel.backgroundColor = UIColor.clearColor()
        self.titleLabel.font = UIFont.appFont(size: 20)
        self.titleLabel.textColor = UIColor.mainTextColor()
        self.contentView.addSubview(self.titleLabel)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setRowData(datas: [Movie], indexPath: NSIndexPath) {
        
        let model: Movie = datas[indexPath.row]
        
        self.thumbnailImage.kf_setImageWithURL(NSURL(string: APIConfig.IMAGE_BASE_DOMINE_w780 + model.backdrop_path)!,
            placeholderImage: nil,
            optionsInfo: nil) {[weak self] (image, error, cacheType, imageURL) -> () in
                guard let `self` = self else { return }
                if cacheType != .Memory {
                    UIView.transitionWithView(`self`.thumbnailImage,
                                                duration: 0.28,
                                                options: .TransitionCrossDissolve,
                                                animations: nil, completion: nil)
                }
        }

        self.titleLabel.text = model.original_title
    }
    
}
