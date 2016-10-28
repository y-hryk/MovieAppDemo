//
//  DiscoverUseCase.swift
//  DEMO
//
//  Created by yamaguchi on 2016/04/14.
//  Copyright © 2016年 h.yamaguchi. All rights reserved.
//

import UIKit

protocol DiscoverUseCaseDelegate: class {
    func useCase(useCase useCase: DiscoverUseCase, changeControllerState: ControllerState)
}

class DiscoverUseCase: NSObject {
    
    weak var delegate: DiscoverUseCaseDelegate?
    var indicatorHidden: Bool = true
    var retryViewHidden: Bool = true
    var noDataViewHidden: Bool = true
    
    var datas = [Movie]()
    var currentPage = 1
    
    var state: ControllerState = .Content {
        willSet {
            self.indicatorHidden = true; self.retryViewHidden = true; self.noDataViewHidden = true ;
            self.state = newValue
            switch newValue {
            case.Content:
                self.noDataViewHidden = !self.datas.isEmpty
            case.Loading:
                self.indicatorHidden = !self.datas.isEmpty
            case.Error:
                self.retryViewHidden = !self.datas.isEmpty
            }
            self.delegate?.useCase(useCase: self, changeControllerState: self.state)
        }
    }

    func requestDiscover(page page: Int, completion: (() -> Void)?) {
        
        if page == 1 {
            self.datas = [Movie]()
        }
        
        self.state = .Loading
        let request = APIClient.DiscoverRequest()
        request.page = page
        
        APIClient().request(request) { [weak self] (response) -> Void in
            guard let `self` = self else { return }
            switch response {
            case .Success(let result):
            
                `self`.datas = `self`.datas + result.results
                `self`.state = .Content
                completion?()
                
            case .Failure(let error):
                `self`.state = .Error
                LOG(error.description)
            }
        }
    }
}

// MARK: UICollectionViewDataSource
extension DiscoverUseCase : UICollectionViewDataSource {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.datas.count
    }
        
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("DiscoverCell", forIndexPath: indexPath) as! DiscoverCell
        
        cell.backgroundColor = UIColor.whiteColor()
        cell.setRowData(self.datas, indexPath: indexPath)
        return cell
    }
}