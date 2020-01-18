//
//  MovieDetailProtocols.swift
//  MoviesApp
//
//  Created by Srikar on 05/01/20.
//  Copyright © 2020 Srikar. All rights reserved.
//

import UIKit

protocol DetailViewToPresenterProtocol: class{
    var view: DetailPresenterToViewProtocol? {get set}
    var interactor: DetailPresenterToInteractorProtocol? {get set}
    var router: DetailPresenterToRouterProtocol? {get set}
    func fetchDetailForMovieWithID(_ searchString:String!)
    func showMovieDetailController(navigationController:UINavigationController, imdbId:String, imgData imageData:Data)
}

protocol DetailPresenterToViewProtocol: class{
    func showMovieDetail(movieDetail:MovieDetail)
    func showError()
    func showErrorForMessage(error:String)
}

protocol DetailPresenterToRouterProtocol: class {
    static func createMovieDetailModule(_ strMovieId:String, imgData imageData:Data)-> MovieDetailViewController
    func pushToMovieDetailScreen(navigationConroller:UINavigationController, imdbId:String, imgData imageData:Data)
}

protocol DetailPresenterToInteractorProtocol: class {
    var presenter:DetailInteractorToPresenterProtocol? {get set}
    func fetchDetailForMovieWithID(_ searchString:String!)
}

protocol DetailInteractorToPresenterProtocol: class {
    func movieDetailFetchSuccess(movieDetail: MovieDetail)
    func movieDetailFetchFailed()
    func movieDetailFetchFailedWithError(error:String)
}
