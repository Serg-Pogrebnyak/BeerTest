//
//  API.swift
//  Breweries list
//
//  Created by Sergey Pohrebnuak on 16.04.2020.
//  Copyright © 2020 Sergey Pohrebnuak. All rights reserved.
//

import SwiftyJSON

class API {
    
    static var shared = API()
    
    fileprivate static let baseURL = "https://api.openbrewerydb.org/"
    fileprivate static let breweriesList = "breweries"
    fileprivate static let searchList = "breweries?by_name="
    
    enum Method: String {
        case post = "POST"
        case get = "GET"
    }
    
    func getAllBreweries(bysearch: String? = nil, callback: @escaping ([Brewery]?) -> Void) {
        var url: String!
        if bysearch != nil && !bysearch!.isEmpty {
            url = API.searchList + bysearch!
        } else {
            url = API.breweriesList
        }
        sendRequest(API.baseURL + url, method: .get) { (json) in
            guard let arrayOfJson = json?.array, !arrayOfJson.isEmpty else {
                callback(nil)
                return
            }
            
            var arrayOfBreweries = [Brewery]()
            for obect in arrayOfJson {
                arrayOfBreweries.append(Brewery(fromJson: obect))
            }

            callback(arrayOfBreweries)
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
