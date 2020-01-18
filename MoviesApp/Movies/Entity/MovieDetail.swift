//
//  MovieDetail.swift
//  MoviesApp
//
//  Created by Srikar on 05/01/20.
//  Copyright © 2020 Srikar. All rights reserved.
//

import UIKit
import ObjectMapper

private let IMDBID = "imdbID"
private let TITLE = "Title"
private let YEAR = "Year"
private let TYPE = "Type"
private let POSTER = "Poster"
private let RATED = "Rated"
private let RELEASED = "Released"
private let RUNTIME = "Runtime"
private let GENRE = "Genre"
private let DIRECTOR = "Director"
private let WRITER = "Writer"
private let ACTORS = "Actors"
private let PLOT = "Plot"
private let RATING = "imdbRating"
private let VOTES = "imdbVotes"

class MovieDetail: Mappable {
    var year:String!
    var title:String!
    var imdbID:String!
    var type:String!
    var poster:String!
    var dImageData:Data?
    var rated:String!
    var released:String!
    var runtime:String!
    var genre:String!
    var plot:String!
    var writer:String!
    var director:String!
    var actors:String!
    var imdbRating:String!
    var imdbVotes:String!



    required init?(map:Map) {
        mapping(map: map)
    }
    
    func mapping(map:Map){
        poster <- map[POSTER]
        title <- map[TITLE]
        imdbID <- map[IMDBID]
        type <- map[TYPE]
        year <- map[YEAR]
        
        rated <- map[RATED]
        released <- map[RELEASED]
        runtime <- map[RUNTIME]
        genre <- map[GENRE]
        writer <- map[WRITER]
        
        director <- map[DIRECTOR]
        actors <- map[ACTORS]
        imdbRating <- map[RATING]
        imdbVotes <- map[VOTES]
        plot <- map[PLOT]

    }
    
}
