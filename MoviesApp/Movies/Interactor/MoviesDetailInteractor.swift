//
//  MoviesDetailInteractor.swift
//  MoviesApp
//
//  Created by Srikar on 05/01/20.
//  Copyright © 2020 Srikar. All rights reserved.
//

import UIKit
import Foundation
import Alamofire
import ObjectMapper

class MoviesDetailInteractor: DetailPresenterToInteractorProtocol {
    var presenter: DetailInteractorToPresenterProtocol?
    var objServerCommunication:ServerCommunication! = ServerCommunication.sharedInstance

    func fetchDetailForMovieWithID(_ strSearchString:String!) {
        
        var strSearchURL:String! = String.init(stringLiteral: Constants.URLS.k_DISCOVER_URL_PREFIX)
        
        if strSearchString.count > 0 {
            strSearchURL = strSearchURL.appending("i=\(strSearchString ?? "")")
        } else {
            strSearchURL = strSearchURL.appending("i=tt5304172")
        }
        
        strSearchURL = strSearchURL.appending(Constants.APIKey.k_API_KEY)

        print("**********************************************************")
        print(strSearchURL!)

        
        objServerCommunication.sendRequest(strSearchURL, type:"GET", withResult:{
            (response:DataResponse<Any>?)->Swift.Void in
            print("Response - %@", response as Any)
            
            if let status = response?.response?.statusCode {
                switch(status){
                case 200:
                    print("example success")
                default:
                    print("error with response status: \(status)")
                }
            }
            if let result = response!.result.value {
                let JSON = result as! NSDictionary
                
                if (JSON.object(forKey: "Response") as! String == "False") {
                    let error = JSON.object(forKey: "Error") as! String
                    self.presenter?.movieDetailFetchFailedWithError(error: error)
                } else {
                    
                    let objMovieDetail:MovieDetail! = Mapper<MovieDetail>().map(JSON: JSON as! [String : Any])
                    self.presenter?.movieDetailFetchSuccess(movieDetail: objMovieDetail)
                }
            }else {
                self.presenter?.movieDetailFetchFailed()
            }
        })
    }
    
    func fetchImagesForMovies(_ movieDetail:MovieDetail)->MovieDetail {
        if movieDetail.poster != nil {
            let url = URL(string: Constants.URLS.k_POSTER_URL_PREFIX + movieDetail.poster!)
            self.downloadImageFromURL(url!, withResult: {
                (data:Data!)->Swift.Void in
                if data != nil {
                    movieDetail.dImageData = data
                } else {
                    movieDetail.dImageData = nil
                }
            })
        }
        return movieDetail
    }
    
    func downloadImageFromURL(_ url: URL, withResult handler: @escaping(_ data:Data?)->Swift.Void) {
        let data = try? Data(contentsOf: url)
        handler(data)
    }
}
