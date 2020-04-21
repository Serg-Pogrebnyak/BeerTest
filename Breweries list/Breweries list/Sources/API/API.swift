//
//  API.swift
//  Breweries list
//
//  Created by Sergey Pohrebnuak on 16.04.2020.
//  Copyright © 2020 Sergey Pohrebnuak. All rights reserved.
//

import SwiftyJSON
import CoreData

class API {
    
    static var shared = API()
    
    fileprivate static let baseURL = "https://api.openbrewerydb.org/"
    fileprivate static let breweriesList = "breweries"
    fileprivate static let searchList = "breweries?by_name="
    
    enum Method: String {
        case post = "POST"
        case get = "GET"
    }
    
    func getAllBreweries(callback: @escaping (Bool) -> Void) {
        sendRequest(API.baseURL + API.breweriesList, method: .get) { (json) in
            guard let arrayOfJson = json?.array, !arrayOfJson.isEmpty else {
                callback(false)
                return
            }
            
            CoreManager.shared.mergeDataWithLocalBreweries(jsonArray: arrayOfJson) { (newData) in
                callback(newData == nil ? false : true)
            }
        }
    }
    
    func searchBreweries(bysearch: String, callback: @escaping ([Brewery]?) -> Void) {
        sendRequest(API.baseURL + API.searchList + bysearch, method: .get) { (json) in
            guard let arrayOfJson = json?.array, !arrayOfJson.isEmpty else {
                callback(nil)
                return
            }
            
            CoreManager.shared.mergeDataWithLocalBreweries(jsonArray: arrayOfJson) { (newData) in
                callback(newData)
            }
        }
    }
    
    fileprivate func sendRequest(_ url: String,
                                 method: Method = .post,
                                 jsonParams: [String : Any]? = nil,
                                 callback: @escaping ((JSON?) -> ())) {
        do {
            guard let url = URL.init(string: url) else {
                callback(nil)
                return
            }
            let session = URLSession.shared
            session.configuration.timeoutIntervalForRequest = 60.0
            var request = URLRequest(url: url)
            request.httpMethod = method.rawValue

            if let jsonParams = jsonParams {
                request.httpBody = try JSONSerialization.data(withJSONObject: jsonParams, options: .prettyPrinted)
            }
            
            let task = session.dataTask(with: request, completionHandler: {(data, response, error) in
                guard   let data:Data = data,
                        let _:URLResponse = response,
                        error == nil,
                        let httpUrlResponse = response as? HTTPURLResponse,
                        httpUrlResponse.statusCode == 200,
                        let jsonObject = try? JSON(data: data)
                else {
                    callback(nil)
                    return
                }
                callback(jsonObject)
                
            })
            task.resume()
        } catch {
            fatalError("can't add body")
        }
    }
}
