//
//  Breweries.swift
//  Breweries list
//
//  Created by Sergey Pohrebnuak on 16.04.2020.
//  Copyright © 2020 Sergey Pohrebnuak. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Breweries {
    
    let name: String
    let id: String
    let updatedAt: String
    
    let phone: String?
    let country: String?
    let latitude: String?
    let longitude: String?
    let city: String?
    let street: String?
    let state: String?
    let website_url: String?
    
    init(fromJson json:JSON) {
        self.name = json["name"].stringValue
        self.id = json["id"].stringValue
        self.updatedAt = json["updated_at"].stringValue
        
        self.phone = json["phone"].string
        self.country = json["country"].string
        self.latitude = json["latitude"].string
        self.longitude = json["longitude"].string
        self.city = json["city"].string
        self.street = json["street"].string
        self.state = json["state"].string
        self.website_url = json["website_url"].string
    }
}
