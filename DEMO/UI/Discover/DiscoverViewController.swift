//
//  DiscoverViewController.swift
//  DEMO
//
//  Created by yamaguchi on 2016/04/08.
//  Copyright © 2016年 h.yamaguchi. All rights reserved.
//

import UIKit

class DiscoverViewController: UIViewController {
    
    private var collectionView : UICollectionView!
    private var refreshControl: UIRefreshControl?
    private var useCase = DiscoverUseCase()
    
    private var loadingView: LoadingView!
    private var retryView: RetryView!
    private var emptyView: EmptyView!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Discover"
        self.view.backgroundColor = UIColor.baseColor()

        // UserCase
        self.useCase.delegate = self
        // views
        self.setupViews()
    }
    
    // MARK: Private
    func setupViews() {
        // collection
        self.collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: UICollectionViewFlowLayout())
        self.collectionView.backgroundColor = UIColor.baseColor()
        self.collectionView.registerClass(DiscoverCell.self, forCellWithReuseIdentifier: "DiscoverCell")
        self.collectionView.dataSource = self.useCase
        self.collectionView.delegate = self
        self.view.addSubview(collectionView)
        self.collectionView.registerClass(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "footer")
        
        // State View
        self.loadingView = LoadingView(frame: self.view.bounds)
        self.view.addSubview(self.loadingView)
        
        self.retryView = RetryView(frame: self.view.bounds)
        self.retryView.button.addTarget(self, action: #selector(refresh(_:)), forControlEvents: .TouchUpInside)
        self.view.addSubview(self.retryView)
        
        self.emptyView = EmptyView(frame: self.view.bounds)
        self.emptyView.button.addTarget(self, action: #selector(refresh(_:)), forControlEvents: .TouchUpInside)
        self.view.addSubview(self.emptyView)
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.addTarget(self, action: #selector(refresh(_:)), forControlEvents: .ValueChanged)
        self.collectionView.addSubview(self.refreshControl!)
        
        
        self.loadData(self.useCase.currentPage)
    }
    
    func loadData(page: Int) {
        if (self.useCase.state == .Loading) { return }
        
        self.useCase.requestDiscover(page: self.useCase.currentPage) { [weak self] () -> Void in
            self?.collectionView.reloadData()
            self?.refreshControl?.endRefreshing()
        }
    }
    
    // MARK: Selector
    func refresh(control: UIRefreshControl) {
        self.useCase.currentPage = 1
        self.refreshControl?.beginRefreshing()
        self.loadData(self.useCase.currentPage)
    }
}

// MARK: DiscoverUseCaseDelegate
extension DiscoverViewController: DiscoverUseCaseDelegate {
    
    func useCase(useCase useCase: DiscoverUseCase, changeControllerState: ControllerState) {
        self.loadingView.hidden = useCase.indicatorHidden
        self.retryView.hidden = useCase.retryViewHidden
        self.emptyView.hidden = useCase.noDataViewHidden
    }
}

// MARK: UICollectionViewDelegate
extension DiscoverViewController: UICollectionViewDelegate {

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0.0
    }

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: DiscoverCell.width, height: DiscoverCell.height)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let model = self.useCase.datas[indexPath.row]
        
        let movieDetail_vc = MovieDetailViewController()
        movieDetail_vc.movieId = model.movieId
        self.navigationController?.pushViewController(movieDetail_vc, animated: true)
    }
}

// MARK: UIScrollViewDelegate
extension DiscoverViewController: UIScrollViewDelegate
{
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if self.collectionView.contentOffset.y >= (self.collectionView.contentSize.height - self.collectionView.bounds.size.height) {
    
            if (self.useCase.state == .Loading) { return }
            
            self.useCase.currentPage += 1
            self.useCase.requestDiscover(page: self.useCase.currentPage) { [weak self] () -> Void in
                guard let `self` = self else { return }
                `self`.collectionView.reloadData()
                `self`.refreshControl?.endRefreshing()
            }
        }
    }
}