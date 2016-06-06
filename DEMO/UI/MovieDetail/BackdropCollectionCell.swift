//
//  BackdropCollectionCell.swift
//  DEMO
//
//  Created by yamaguchi on 2016/04/28.
//  Copyright © 2016年 h.yamaguchi. All rights reserved.
//

import UIKit

class BackdropCollectionCell: UICollectionViewCell {
    
    static let margin: CGFloat = 10
    static let width: CGFloat = 140
    static let height: CGFloat = (BackdropCollectionCell.width * 9) / 16 + (BackdropCollectionCell.margin * 2)
    
    var backdropImage: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViews()
    }
    
    func setupViews() {
    
        self.backdropImage = UIImageView(frame: CGRectMake(0, 0, self.contentView.frame.width, self.contentView.frame.height))
        self.backdropImage.backgroundColor = UIColor.imagePlaceholderColor()
        self.contentView.addSubview(self.backdropImage)
    }
    
    func setRowData(datas: [Backdrop], indexPath: NSIndexPath) {
        let model: Backdrop = datas[indexPath.row]
        
        backdropImage.kf_setImageWithURL(NSURL(string: APIConfig.IMAGE_BASE_DOMINE_w300 + model.file_path)!,
            placeholderImage: nil,
            optionsInfo: nil) {[weak self] (image, error, cacheType, imageURL) -> () in
                if cacheType != .Memory {
                    guard let `self` = self else { return }
                    UIView.transitionWithView(`self`.backdropImage,
                        duration: 0.28,
                        options: .TransitionCrossDissolve,
                        animations: nil, completion: nil)
                }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
