//
//  CastCell.swift
//  DEMO
//
//  Created by yamaguchi on 2016/04/26.
//  Copyright © 2016年 h.yamaguchi. All rights reserved.
//

import UIKit

class CastCollectionCell: UICollectionViewCell {
    
    static let margin: CGFloat = 10
    static let width: CGFloat = UIScreen.mainScreen().bounds.size.width / 2
    static let height: CGFloat = 100
    
    let labelMargin: CGFloat = 5.0
    var castImage: UIImageView!
    var nameLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.castImage = UIImageView(frame: CGRectMake(0, 0, 60, self.contentView.frame.height))
        self.castImage.backgroundColor = UIColor.imagePlaceholderColor()
        self.contentView.addSubview(self.castImage)
        
        let castImageRight: CGFloat = self.castImage.frame.origin.x + self.castImage.frame.width
        let nameLabelWidth: CGFloat = self.contentView.frame.width - self.castImage.frame.width
        self.nameLabel = UILabel(frame: CGRectMake(castImageRight + self.labelMargin, 0, nameLabelWidth - (self.labelMargin), contentView.frame.height))
        self.nameLabel.backgroundColor = UIColor.clearColor()
        self.nameLabel.textColor = UIColor.mainTextColor()
        self.nameLabel.numberOfLines = 0
        self.nameLabel.lineBreakMode = .ByCharWrapping
//        self.nameLabel.text = "Johnny Depp\nas Jack Sparrow"
        self.nameLabel.font = UIFont.appFont(size: 10)
        self.contentView.addSubview(self.nameLabel)
    }
    
    func setRowData(datas: [Cast], indexPath: NSIndexPath) {
        let model: Cast = datas[indexPath.row]
        
        self.castImage.kf_setImageWithURL(NSURL(string: APIConfig.IMAGE_BASE_DOMINE_w92 + model.profile_path)!,
            placeholderImage: nil,
            optionsInfo: nil) {[weak self] (image, error, cacheType, imageURL) -> () in
                guard let `self` = self else { return }
                
                if cacheType != .Memory {
                    UIView.transitionWithView(`self`.castImage,
                        duration: 0.28,
                        options: .TransitionCrossDissolve,
                        animations: nil, completion: nil)
                }
        }
        
        self.nameLabel.text = "\(model.name)" + "\nas \(model.character)"

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
