//
//  MovieCastCell.swift
//  DEMO
//
//  Created by yamaguchi on 2016/04/26.
//  Copyright © 2016年 h.yamaguchi. All rights reserved.
//

import UIKit

class CastCell: UITableViewCell {
    
    static let height: CGFloat = 120
    private let margin : CGFloat = 10.0
    
    private var titleLabel: UILabel!
    
    // collectionView
    private var collectionView: UICollectionView!
    private var datas = [Cast]()

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
        self.titleLabel.text = "Cast"
        self.titleLabel.textColor = UIColor.subTextColor()
        self.titleLabel.font = UIFont.appFont(size: 13)
        self.contentView.addSubview(self.titleLabel)
        
        let titleLabelBottom: CGFloat = self.titleLabel.frame.origin.y + self.titleLabel.frame.size.height

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .Horizontal
        
        // collection
        self.collectionView = UICollectionView(frame: CGRectMake(0, titleLabelBottom, width, CastCollectionCell.height), collectionViewLayout: layout)
        self.collectionView.backgroundColor = UIColor.clearColor()
        self.collectionView.registerClass(CastCollectionCell.self, forCellWithReuseIdentifier: "CastCollectionCell")
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.showsHorizontalScrollIndicator = false
        self.collectionView.alwaysBounceHorizontal = true
        self.contentView.addSubview(self.collectionView)
    }
    
    func setRowData(datas: [Cast], indexPath: NSIndexPath) {
        self.datas = datas
        self.collectionView.reloadData()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

extension CastCell: UICollectionViewDataSource {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.datas.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CastCollectionCell", forIndexPath: indexPath) as! CastCollectionCell
        
        cell.backgroundColor = UIColor.clearColor()
        cell.setRowData(self.datas, indexPath: indexPath)
        return cell
    }
}

extension CastCell: UICollectionViewDelegate {
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: CastCollectionCell.margin, left: CastCollectionCell.margin, bottom: CastCollectionCell.margin, right: CastCollectionCell.margin)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: CastCollectionCell.width, height: CastCollectionCell.height - (CastCollectionCell.margin * 2))
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return CastCollectionCell.margin
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
    }
}

