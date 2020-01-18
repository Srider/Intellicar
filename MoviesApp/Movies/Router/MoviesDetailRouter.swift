//
//  MoviesDetailRouter.swift
//  MoviesApp
//
//  Created by Srikar on 05/01/20.
//  Copyright © 2020 Srikar. All rights reserved.
//

import UIKit

class MoviesDetailRouter:DetailPresenterToRouterProtocol
{
    
    static func createMovieDetailModule(_ strMovieId:String, imgData imageData:Data) -> MovieDetailViewController {
        
        let view = mainstoryboard.instantiateViewController(withIdentifier: "MovieDetailViewController") as! MovieDetailViewController
        
        let presenter: DetailViewToPresenterProtocol & DetailInteractorToPresenterProtocol = MoviesDetailPresenter()
        let interactor: DetailPresenterToInteractorProtocol = MoviesDetailInteractor()
        let router:DetailPresenterToRouterProtocol = MoviesDetailRouter()
        view.strMovieID = strMovieId
        view.dImageData = imageData
        view.movieDetailPresenter = presenter
        presenter.view = view as! DetailPresenterToViewProtocol
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view
        
    }
    
    static var mainstoryboard: UIStoryboard{
        return UIStoryboard(name:"Main",bundle: Bundle.main)
    }
    
    func pushToMovieDetailScreen(navigationConroller navigationController:UINavigationController, imdbId strMovieId:String, imgData imageData:Data) {
        
        let movieModule = MoviesDetailRouter.createMovieDetailModule(strMovieId, imgData: imageData)
        navigationController.pushViewController(movieModule,animated: true)
        
    }
    
}
