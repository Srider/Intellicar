//
//  File.swift
//  MoviesApp
//
//  Created by Srikar on 07/08/19.
//  Copyright © 2019 Srikar. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import RSCSearch

class MoviesInteractor: PresenterToInteractorProtocol{
    var arrMoviesList:Array<Movie>?
    var presenter: InteractorToPresenterProtocol?
    var objSearchManager:NetworkManager! = NetworkManager.sharedServiceManager

    //Protocol method to scale for APIs based on slection.
    func fetchMoviesBasedOnSelection(_ strSearchString:String!) {
        
        //https://omdbapi.com/?s=<SEARCH>&apikey=a0783fa9
        
        
        var strSearchURL:String! = String.init(stringLiteral: Constants.URLS.k_DISCOVER_URL_PREFIX)
        
        if strSearchString.count > 0 {
            strSearchURL = strSearchURL.appending("s=\(strSearchString ?? "")")
        } else {
            strSearchURL = strSearchURL.appending("s=sky")
        }
        
        strSearchURL = strSearchURL.appending(Constants.APIKey.k_API_KEY)

        print("**********************************************************")
        print(strSearchURL)

        objSearchManager.addRequestToQueue(strSearchURL, onSuccess:didUpdateSearchResults, onFailure:didFailToSendRequest)
    }
    
    
    func fetchImagesForMovies(_ arrMovies:Array<Movie>)->Array<Movie> {
        for objMovie in arrMovies {
            if objMovie.poster != nil {
                let url = URL(string:objMovie.poster!)
                self.downloadImageFromURL(url!, withResult: {
                    (data:Data!)->Swift.Void in
                    if data != nil {
                        objMovie.dImageData = data
                    } else {
                        objMovie.dImageData = nil
                    }
                })
            }
        }
        return arrMovies
    }
    
    func downloadImageFromURL(_ url: URL, withResult handler: @escaping(_ data:Data?)->Swift.Void) {
        let data = try? Data(contentsOf: url)
        handler(data)
    }
    
    
    //MARK: didFailToSendRequest()
    func didFailToSendRequest()->Void {
        self.presenter?.movieFetchFailed()
    }
    
    //MARK: didUpdateSearchResults()
    func didUpdateSearchResults(_ dictData:AnyObject!)->Void {
        print(dictData)
        print("**********************************************************")

        if (dictData["Response"] as! String == "False") {
            let error = dictData["Error"] as! String
            self.presenter?.movieFetchFailedWithError(error: error)
        } else {
            let arrMovies:Array<Dictionary> = dictData["Search"] as! Array<Dictionary<AnyHashable, Any>>
            var arrMoviesList:Array<Movie> = Mapper<Movie>().mapArray(JSONArray: arrMovies as! [[String : Any]])
            self.presenter?.movieFetchSuccess(movieArray: fetchImagesForMovies(arrMoviesList))
        }
    }
}
