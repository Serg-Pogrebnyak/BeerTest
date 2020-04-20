//
//  Brewery.swift
//  Breweries list
//
//  Created by Sergey Pohrebnuak on 16.04.2020.
//  Copyright © 2020 Sergey Pohrebnuak. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Brewery {
    //requiered information
    private let name: String
    private let id: String
    private let updatedAt: String
    //optional information
    private let phone: String?
    private let country: String?
    private let city: String?
    private let street: String?
    private let state: String?
    //information for map or web view
    private let latitude: String?
    private let longitude: String?
    private let website_url: String?
    
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
    
    func getName() -> String {
        return self.name
    }
    
    func getWebSiteForDisplay() -> (informationForDisplay: NSAttributedString, webSiteURL: URL)? {
        if website_url != nil && !website_url!.isEmpty, let webSiteURL = URL(string: website_url!) {
            let siteInfo = configureInfoForDisplay(desc: "Website: ",
                                                   info: website_url!,
                                                   shouldUnderlineInfo: true)
            return (siteInfo, webSiteURL)
        } else {
            return nil
        }
    }
    
    func getInformationForDisplay() -> [NSAttributedString] {
        var informationArray = [NSAttributedString]()

        if phone != nil && !phone!.isEmpty {
            let phoneInfo = configureInfoForDisplay(desc: "Phone: ", info: phone!)
            informationArray.append(phoneInfo)
        }
        if country != nil && !country!.isEmpty {
            let countryInfo = configureInfoForDisplay(desc: "Country: ", info: country!)
            informationArray.append(countryInfo)
        }
        if state != nil && !state!.isEmpty {
            let stateInfo = configureInfoForDisplay(desc: "State: ", info: state!)
            informationArray.append(stateInfo)
        }
        if city != nil && !city!.isEmpty {
            let cityInfo = configureInfoForDisplay(desc: "City: ", info: city!)
            informationArray.append(cityInfo)
        }
        if street != nil && !street!.isEmpty {
            let streetInfo = configureInfoForDisplay(desc: "Street: ", info: street!)
            informationArray.append(streetInfo)
        }

        return informationArray
    }
    
    func getMapAnnottaion() -> MapBreweryAnnotation? {
        return MapBreweryAnnotation.init(name: name, address: street, latitude: latitude, longitude: longitude)
    }
    
    fileprivate func configureInfoForDisplay(desc: String,
                                             info: String,
                                             shouldUnderlineInfo: Bool = false) -> NSAttributedString {
        let attributeForDesc = [ NSAttributedString.Key.foregroundColor: UIColor.init(red: 139.0/255.0, green: 139.0/255.0, blue: 139.0/255.0, alpha: 1.0) ]
        let attributedDescString = NSMutableAttributedString(string: desc, attributes: attributeForDesc)
        
        var attributeForInfo: [NSAttributedString.Key : Any] = [ NSAttributedString.Key.foregroundColor: UIColor.init(red: 69.0/255.0, green: 69.0/255.0, blue: 69.0/255.0, alpha: 1.0) ]
        
        if shouldUnderlineInfo {
            attributeForInfo[NSAttributedString.Key.underlineStyle] = NSUnderlineStyle.single.rawValue
        }
        
        let attributedInfoString = NSAttributedString(string: info, attributes: attributeForInfo)
        attributedDescString.append(attributedInfoString)

        return attributedDescString
    }
}
