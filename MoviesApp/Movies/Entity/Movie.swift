//
//  Movie.swift
//  MovieApp
//
//  Created by Srikar on 29/07/19.
//  Copyright © 2019 Srikar. All rights reserved.
//

import UIKit
import ObjectMapper

private let IMDBID = "imdbID"
private let TITLE = "Title"
private let YEAR = "Year"
private let TYPE = "Type"
private let POSTER = "Poster"

class Movie: Mappable {
    var year:String!
    var title:String!
    var imdbID:String!
    var type:String!
    var poster:String!
    var dImageData:Data?
    var bImageFetchCompleted:Bool!

    
    required init?(map:Map) {
        mapping(map: map)
    }
    
    func mapping(map:Map){
        poster <- map[POSTER]
        title <- map[TITLE]
        imdbID <- map[IMDBID]
        type <- map[TYPE]
        year <- map[YEAR]
    }
    
}
