//
//  MovieProtocols.swift
//  MovieApp
//
//  Created by Srikar on 07/08/19.
//  Copyright © 2019 Srikar. All rights reserved.
//

import Foundation
import UIKit

protocol ViewToPresenterProtocol: class{
    var view: PresenterToViewProtocol? {get set}
    var interactor: PresenterToInteractorProtocol? {get set}
    var router: PresenterToRouterProtocol? {get set}
    func fetchMoviesBasedOnSelection(_ searchString:String!)
    func showMovieController(navigationController:UINavigationController)
}

protocol PresenterToViewProtocol: class{
    func showMovies(movieArray:Array<Movie>)
    func showError()
    func showErrorForMessage(error:String)
}

protocol PresenterToRouterProtocol: class {
    static func createModule()-> MoviesViewController
    func pushToMovieScreen(navigationConroller:UINavigationController)
}

protocol PresenterToInteractorProtocol: class {
    var presenter:InteractorToPresenterProtocol? {get set}
    func fetchMoviesBasedOnSelection(_ searchString:String!)
}

protocol InteractorToPresenterProtocol: class {
    func movieFetchSuccess(movieArray:Array<Movie>)
    func movieFetchFailed()
    func movieFetchFailedWithError(error:String)
//    func refreshImageItems(imageArray:Array<Movie>)
}
