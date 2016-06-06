//
//  MovieDetailViewController.swift
//  DEMO
//
//  Created by yamaguchi on 2016/04/14.
//  Copyright © 2016年 h.yamaguchi. All rights reserved.
//

import UIKit
import StretchHeader

class MovieDetailViewController: UIViewController {
    
    var movieId = 0
    private var tableView: UITableView!
    private var header: StretchHeader!
    private var navigationView = UIView()
    private var navigationTitleLabel = UILabel()
    
    private var loadingView: LoadingView!
    private var retryView: RetryView!
    
    private var useCase = MovieDetailUseCase()
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.baseColor()
        // views
        self.setupViews()
        // useCase
        self.useCase.delegate = self
        //
        self.loadData()
    }
    
    // MARK: Private
    func setupViews() {
        self.tableView = UITableView(frame: self.view.bounds, style: .Plain)
        self.tableView.backgroundColor = UIColor.baseColor()
        self.tableView.registerClass(InfoCell.self, forCellReuseIdentifier: "InfoCell")
        self.tableView.registerClass(BackdropCell.self, forCellReuseIdentifier: "BackdropCell")
        self.tableView.registerClass(OverViewCell.self, forCellReuseIdentifier: "OverViewCell")
        self.tableView.registerClass(CastCell.self, forCellReuseIdentifier: "CastCell")
        self.tableView.separatorStyle = .None
        self.view.addSubview(self.tableView)
        
        self.tableView.dataSource = useCase
        self.tableView.delegate = self
        
        self.tableView.hidden = true
        
        // State View
        self.loadingView = LoadingView(frame: self.view.bounds)
        self.view.addSubview(self.loadingView)
        
        self.retryView = RetryView(frame: self.view.bounds)
        self.retryView.button.addTarget(self, action: #selector(loadData), forControlEvents: .TouchUpInside)
        self.view.addSubview(self.retryView)
        
        self.setupHeaderView()
        self.setupNavigationView()
        self.setupFooterView()
    }
    
    func loadData() {
        if (self.useCase.state == .Loading) { return }
        
        // api
        self.useCase.requestMovieDetail(self.movieId) {[weak self] () -> Void in
            guard let `self` = self else { return }
            `self`.tableView.hidden = false
            UIView.transitionWithView(`self`.tableView,
                                      duration: 0.35,
                                      options: .TransitionCrossDissolve,
                                      animations: nil, completion: nil)
            
            guard let model = `self`.useCase.movie else { return }
            `self`.header.imageView.kf_setImageWithURL(NSURL(string: APIConfig.IMAGE_BASE_DOMINE_w780 + model.backdrop_path)!)
            `self`.navigationTitleLabel.text = model.original_title
        }
        
        self.useCase.requestBackdrops(self.movieId) {[weak self] () -> Void in
            guard let `self` = self else { return }
            `self`.tableView.reloadData()
        }
        
        self.useCase.requestCasts(self.movieId) {[weak self] () -> Void in
            guard let `self` = self else { return }
            `self`.tableView.reloadData()
        }
    }
    
    func setupNavigationView() {
        // NavigationHeader
        let navibarHeight : CGFloat = CGRectGetHeight(navigationController!.navigationBar.bounds)
        let statusbarHeight : CGFloat = UIApplication.sharedApplication().statusBarFrame.size.height
        
        let gradientView = UIView(frame: CGRectMake(0, 0, view.frame.size.width, navibarHeight + statusbarHeight))
        UIColor.gradientStartColor(UIColor.RGBA(0, 0, 0, 0.7),
            endColor: UIColor.RGBA(0, 0, 0, 0.0),
            view: gradientView,
            type: .angle0)
        self.view.addSubview(gradientView)
        
        self.navigationView.frame = CGRectMake(0, 0, view.frame.size.width, navibarHeight + statusbarHeight)
        self.navigationView.backgroundColor = UIColor.baseColor()
        self.navigationView.alpha = 0.0
        self.view.addSubview(self.navigationView)
        
        self.navigationTitleLabel.frame = CGRectMake(50, statusbarHeight, self.navigationView.frame.width - 100, navibarHeight)
        self.navigationTitleLabel.font = UIFont.appFont(size: 20)
        self.navigationTitleLabel.backgroundColor = UIColor.clearColor()
        self.navigationTitleLabel.textColor = UIColor.whiteColor()
        self.navigationTitleLabel.textAlignment = .Center
        self.navigationTitleLabel.lineBreakMode = .ByTruncatingTail
        self.navigationView.addSubview(self.navigationTitleLabel)
        
        // back button
        let button = UIButton(type: .Custom)
        button.frame = CGRectMake(10, 20, 44, 44)
        button.setImage(UIImage(named: "navi_back_btn")?.imageWithRenderingMode(.AlwaysTemplate), forState: .Normal)
        button.tintColor = UIColor.whiteColor()
        button.addTarget(self, action: #selector(leftButtonAction), forControlEvents: .TouchUpInside)
        self.view.addSubview(button)
    }
    
    func setupHeaderView() {
        
        let options = StretchHeaderOptions()
        options.position = .FullScreenTop
        
        self.header = StretchHeader()
        self.header.imageView.backgroundColor = UIColor.imagePlaceholderColor()
        self.header.stretchHeaderSize(headerSize: CGSizeMake(self.view.frame.size.width, (self.view.frame.size.width * 9) / 16),
            imageSize: CGSizeMake(self.view.frame.size.width, (self.view.frame.size.width * 9) / 16),
            controller: self,
            options: options)
        
        self.tableView.tableHeaderView = self.header
    }
    
    func setupFooterView() {
        
        let footerView = UIView(frame: CGRectMake(0,0,self.view.frame.width,60))
        footerView.backgroundColor = UIColor.clearColor()
        
        let buttonMargin: CGFloat = 10.0
        
        let trailerButton = UIButton(type: .RoundedRect)
        trailerButton.frame = CGRectMake(buttonMargin, buttonMargin, (self.view.frame.width - (buttonMargin * 2)), 40)
        trailerButton.backgroundColor = UIColor.accentColor()
        trailerButton.setTitle("Watch Trailer", forState: .Normal)
        trailerButton.titleLabel?.font = UIFont.appFont(size: 16)
        trailerButton.setTitleColor(UIColor.mainTextColor(), forState: .Normal)
        trailerButton.layer.cornerRadius = 6.0
        footerView.addSubview(trailerButton)
        
        self.tableView.tableFooterView = footerView
    }
    
    // MARK: Selector
    func leftButtonAction() {
        self.navigationController?.popViewControllerAnimated(true)
    }
}

// MARK: MovieDetailUseCase
extension MovieDetailViewController: MovieDetailUseCaseDelegate {
    func useCase(useCase useCase: MovieDetailUseCase, changeControllerState: ControllerState) {
        self.loadingView.hidden = useCase.indicatorHidden
        self.retryView.hidden = useCase.retryViewHidden
    }
}

// MARK: UITableViewDelegate
extension MovieDetailViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        let section: MovieDetailType = MovieDetailType(rawValue: indexPath.row)!
        switch section {
        case .Info:
            return InfoCell.height
        case .Backdrop:
            return BackdropCell.height
        case .OverView:
            return OverViewCell.height
        case .Cast:
            return CastCell.height
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
}

// MARK: UIScrollViewDelegate
extension MovieDetailViewController: UIScrollViewDelegate
{
    func scrollViewDidScroll(scrollView: UIScrollView) {
        self.header.updateScrollViewOffset(scrollView)
        
        // NavigationHeader alpha update
        let offset : CGFloat = scrollView.contentOffset.y
        if (offset > 50) {
            let alpha : CGFloat = min(CGFloat(1), CGFloat(1) - (CGFloat(50) + (navigationView.frame.height) - offset) / (navigationView.frame.height))
            self.navigationView.alpha = CGFloat(alpha)
            
        } else {
            self.navigationView.alpha = 0.0;
        }
    }
}