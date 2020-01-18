//
//  ServerCommunication.swift
//  MovieApp
//
//  Created by Srikar on 30/07/19.
//  Copyright © 2019 Srikar. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper

class ServerCommunication: NSObject  {
    static let sharedInstance = ServerCommunication()
    let apiKey:String! = Constants.APIKey.k_API_KEY
    var url:String?
    var objSessionManager:SessionManager? = SessionManager.default

    private override init() {
        
    }
    
    func sendSearchRequest (_ strSearchString:String!) {
        let sDiscoverMoviesURL = Constants.URLS.k_DISCOVER_URL_PREFIX
        
        //https://omdbapi.com/?i=<imdbID>&apikey=a0783fa9
        
       var strSearchURL:String! = String.init(stringLiteral: Constants.URLS.k_DISCOVER_URL_PREFIX)
        
        if strSearchString.count > 0 {
            strSearchURL = strSearchURL.appending("i=\(strSearchString ?? "")")
        } else {
            strSearchURL = strSearchURL.appending("i=tt5304172")
        }
        
        strSearchURL = strSearchURL.appending(Constants.APIKey.k_API_KEY)

        print("**********************************************************")
        print(strSearchURL)
        
        self.sendRequest(strSearchURL, type:"GET", withResult:{
            (response:DataResponse<Any>?)->Swift.Void in
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
                    let dictData:Dictionary! = [Constants.ResponseStatusKeys.kJSONResponseCode: NSNumber.init(value: Constants.ResponseStatusKeys.kJSONResponseFailedStatus), Constants.ResponseStatusKeys.kJSONResponseMessage:Constants.ResponseStatusKeys.kJSONResponseNotFound, Constants.ResponseStatusKeys.kJSONResponseResult:Constants.ResponseStatusKeys.kJSONResponseNotFound]
                    
                    DispatchQueue.main.async {
                        NotificationCenter.default.post(name:Notification.Name(rawValue:Constants.Notifications.kNetworkOperationFailure), object: dictData, userInfo: nil)
                    }
                } else {
                    let arrMovies:Array<Dictionary> = JSON.object(forKey: "Search") as! Array<Dictionary<AnyHashable, Any>>
                    let arrayObject = Mapper<Movie>().mapArray(JSONArray: arrMovies as! [[String : Any]]);
                    
                    let dictData:Dictionary! = [Constants.ResponseStatusKeys.kJSONResponseData: arrayObject, Constants.ResponseStatusKeys.kJSONResponseCode: NSNumber.init(value: Constants.ResponseStatusKeys.kJSONResponseSuccessStatus), Constants.ResponseStatusKeys.kJSONResponseResult:Constants.ResponseStatusKeys.kJSONResponseSuccess]

                    /* Send Notification */
                    DispatchQueue.main.async {
                        NotificationCenter.default.post(name:Notification.Name(rawValue:Constants.Notifications.kNetworkOperationSuccess), object: dictData, userInfo: nil)
                    }
                }
            }else {
                            
                let dictData:Dictionary! = [Constants.ResponseStatusKeys.kJSONResponseCode: NSNumber.init(value: Constants.ResponseStatusKeys.kJSONResponseFailedStatus), Constants.ResponseStatusKeys.kJSONResponseResult:Constants.ResponseStatusKeys.kJSONResponseNotFound]
                
                DispatchQueue.main.async {
                    NotificationCenter.default.post(name:Notification.Name(rawValue:Constants.Notifications.kNetworkOperationFailure), object: dictData, userInfo: nil)
                }
            }
        })
    }
    
        
    func sendRequest(_ urlPrefix:String!, type requestType:String!, withResult result:@escaping(_ response:DataResponse<Any>?)->Swift.Void) {
        url = urlPrefix
        print(url!)
        send_request(url!, type:requestType, handler: result)
    }
    
    func send_request(_ url:String,  type requestType:String!, handler:@escaping(_ response:DataResponse<Any>?)->Void) {
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default)
            .downloadProgress(queue: DispatchQueue.global(qos: .utility)) { progress in
                print("Progress: \(progress.fractionCompleted)")
            }
            .validate { request, response, data in
                return .success
            }
            .responseJSON { response in
                handler(response)
        }
    }
}
