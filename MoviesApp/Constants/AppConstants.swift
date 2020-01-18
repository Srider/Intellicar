//
//  AppConstants.swift
//  Symbio_Countries
//
//  Created by Honeywell on 18/11/17.
//  Copyright © 2017 Honeywell. All rights reserved.
//

import Foundation

struct Constants {
    
    struct Alerts {
        static let kCountrySearchTitle = "Movie Search"
        static let NETWORK_ALERT = "Network alert"
        static let kNoNetworkMessage = "Network not available."
        static let kNetworkAvailableMessage = "Internet is available."
        
        static let kOkayButtontitle = "Okay"
        
        static let NO_COUNTRIES_ALERT = "No movies alert"
        static let kNoCountriesMessage = "No movies available for the given name."
        
        static let COUNTRIES_SEARCH_ALERT = "Search movie alert."
        static let kCountrySearchOperationFailed = "Movie search operation failed !!!"
        
        static let COUNTRY_DETAILS_ALERT = "Movie details alert."
        static let kCountryDetailOperationFailed = "Movie details fetch operation failed !!!"
        
        static let SEARCH_ALERT = "Search alert"
        static let kEmptySearchMessage = "Please enter a valid movie name to search "
    }
    
    struct Timeout {
        static let kNetworkTimeout = 5.0
    }
    
    struct URLS {
        //https://omdbapi.com/?s=<SEARCH>&apikey=a0783fa9
        static let k_GENERIC_URL_PREFIX = "https://omdbapi.com/?"
        static let k_DISCOVER_URL_PREFIX = "https://omdbapi.com/?"
        static let k_POSTER_URL_PREFIX = "https://omdbapi.com/?"
        
    }
    
    struct APIKey {
        static let k_API_KEY = "&apikey=a0783fa9"

    }
    
    struct RequestParam {
        static let kURLRequestType = "GET"
        static let kURLRequestContentValue = "application/json"
        static let kURLRequestContentType = "Content-Type"
    }
    

    
    struct Notifications {
        static let kNetworkReachable = "Reachable"
        static let kNetworkNotReachable = "NotReachable"
        static let kNetworkOperationSuccess = "SuccessNotification"
        static let kNetworkOperationFailure = "FailureNotification"
    }
    
    struct ButtonTitles {
        static let kBackButtonText = "Back"
    }
    
    struct ResponseStatusKeys {
        static let kJSONResponseStatus = "status"
        static let kJSONResponseData = "data"
        static let kJSONResponseCode = "code"
        static let kJSONResponseSuccess = "Success"
        static let kJSONResponseResult = "result"
        static let kJSONResponseMessage = "message"
        static let kJSONResponseNotFound = "Not Found"
        static let kJSONRequestTimedout = "Request Timed Out"
        static let kJSONResponseSuccessStatus = 200
        static let kJSONResponseFailedStatus = 404
        static let kNoResponseText = "Not Available"
    }
    
    struct CellAttributes {
        static let kDataName = "Name"
        static let kDataNativeName = "Native Name"
        static let kDataRegion = "Region"
        static let kDataCapital = "Capital"
        static let kDataLanguages = "Languages"
        static let kDataTranslations = "Translations"
        static let kNoDataText = "Not Available"
    }
    
    struct Caching {
        static let kURLCachedDate = "Cached Date"
        static let kCachedURLType = "https"
    }
    
    struct Cells {
        static let kMovieCell = "MovieInfoCell"
        static let kImageCell = "ImageCell"
        static let kTextCell = "TextCell"
        static let kTitleCell = "TitleCell"
        static let kDescriptionCell = "DescriptionCell"
        static let kDetailsCell = "DetailsCell"
    }
    
    struct AccessibilityIdentifier {
        static let kAccessIdentifierResultCell = "ResultCell"
    }
    
    struct ActivityIndicator {
        static let kLoading = "Loading..."
    }
}

/*!
 @enum ServiceType
 */
enum ServiceType{
    case kMovies
    case kMovieDetail
}
