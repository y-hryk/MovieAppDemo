//
//  MovieDetailUseCase.swift
//  DEMO
//
//  Created by yamaguchi on 2016/04/28.
//  Copyright © 2016年 h.yamaguchi. All rights reserved.
//

import UIKit

protocol MovieDetailUseCaseDelegate: class {
    func useCase(useCase useCase: MovieDetailUseCase, changeControllerState: ControllerState)
}

public enum MovieDetailType: Int {
    case Info
    case Backdrop
    case OverView
    case Cast
    
    static var count: Int {
        return Cast.rawValue + 1
    }
}

class MovieDetailUseCase: NSObject {
    
    weak var delegate: MovieDetailUseCaseDelegate?
    
    var indicatorHidden: Bool = true
    var retryViewHidden: Bool = true
    
    var movie: Movie?
    var casts = [Cast]()
    var backdrops = [Backdrop]()
    
    var state: ControllerState = .Content {
        willSet {
            self.indicatorHidden = true; self.retryViewHidden = true;
            self.state = newValue
            switch newValue {
            case.Content: break
            case.Loading:
                indicatorHidden = self.movie == nil ? false : true
            case.Error:
                retryViewHidden = self.movie == nil ? false : true
            }
            self.delegate?.useCase(useCase: self, changeControllerState: self.state)
        }
    }
    
    func requestMovieDetail(movieId: Int, completion: (() -> Void)?) {
        
        self.state = .Loading
        let request = APIClient.MovieDetailRequest()
        request.movieId = movieId
        
        APIClient().request(request) {[weak self](response) -> Void in
        
            guard let `self` = self else { return }
            switch response {
            case .Success(let result):
                `self`.movie = result
                `self`.state = .Content
                completion?()
                
            case .Failure(let error):
                LOG(error.description)
                `self`.state = .Error
            }
        }
    }
    
    func requestBackdrops(movieId: Int, completion: (() -> Void)?) {
        
        let request_backdrop = APIClient.BackDropRequest()
        request_backdrop.movieId = movieId
        APIClient().request(request_backdrop) {[weak self] (response) -> Void in
            guard let `self` = self else { return }
            switch response {
            case .Success(let result):
                `self`.backdrops = result
                completion?()
            case .Failure(let error):
                LOG(error.description)
            }
        }
    }
    
    func requestCasts(movieId: Int, completion: (() -> Void)?) {
        
        let request_cast = APIClient.CastRequest()
        request_cast.movieId = movieId
        APIClient().request(request_cast) {[weak self](response) -> Void in
            guard let `self` = self else { return }
            switch response {
            case .Success(let result):
                self.casts = result
                completion?()
            case .Failure(let error):
                LOG(error.description)
            }
        }
    }
}

// MARK: UITableViewDataSource
extension MovieDetailUseCase: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MovieDetailType.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let section: MovieDetailType = MovieDetailType(rawValue: indexPath.row)!
        
        switch section {
        case .Info:
            
            let cell = tableView.dequeueReusableCellWithIdentifier("InfoCell") as! InfoCell
            cell.setRowData(self.movie, indexPath: indexPath)
            return cell
            
        case .Backdrop:
            
            let cell = tableView.dequeueReusableCellWithIdentifier("BackdropCell") as! BackdropCell
            cell.setRowData(self.backdrops, indexPath: indexPath)
            return cell
            
        case .OverView:
            
            let cell = tableView.dequeueReusableCellWithIdentifier("OverViewCell") as! OverViewCell
            cell.setRowData(self.movie, indexPath: indexPath)
            return cell
            
        case .Cast:
            
            let cell = tableView.dequeueReusableCellWithIdentifier("CastCell") as! CastCell
            cell.setRowData(self.casts, indexPath: indexPath)
            
            return cell
        }
    }
}

