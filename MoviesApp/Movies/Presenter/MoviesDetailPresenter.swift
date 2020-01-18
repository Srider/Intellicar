//
//  MoviesDetailPresenter.swift
//  MoviesApp
//
//  Created by Srikar on 05/01/20.
//  Copyright © 2020 Srikar. All rights reserved.
//

import UIKit

class MoviesDetailPresenter:DetailViewToPresenterProtocol {
    
    var view: DetailPresenterToViewProtocol?
    
    var interactor: DetailPresenterToInteractorProtocol?
    
    var router: DetailPresenterToRouterProtocol?
    
    func fetchDetailForMovieWithID(_ searchString: String!) {
        interactor?.fetchDetailForMovieWithID(searchString)
    }
    
    func showMovieDetailController(navigationController: UINavigationController, imdbId strMovieId:String, imgData imageData:Data) {
        router?.pushToMovieDetailScreen(navigationConroller:navigationController, imdbId: strMovieId, imgData:imageData)
    }
}

extension MoviesDetailPresenter: DetailInteractorToPresenterProtocol{
   
    func movieDetailFetchSuccess(movieDetail: MovieDetail) {
        view?.showMovieDetail(movieDetail: movieDetail)
    }
    
    func movieDetailFetchFailed() {
        view?.showError()
    }
    
    func movieDetailFetchFailedWithError(error:String) {
        view?.showErrorForMessage(error:error)
    }
}
