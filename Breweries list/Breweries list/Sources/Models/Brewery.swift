//
//  Brewery.swift
//  Breweries list
//
//  Created by Sergey Pohrebnuak on 16.04.2020.
//  Copyright © 2020 Sergey Pohrebnuak. All rights reserved.
//

import Foundation
import SwiftyJSON
import CoreData

class Brewery: NSManagedObject {
    //requiered information
    @NSManaged public var name: String
    @NSManaged public var id: String
    @NSManaged public var updatedAt: String
    //optional information
    @NSManaged public var phone: String?
    @NSManaged public var country: String?
    @NSManaged public var city: String?
    @NSManaged public var street: String?
    @NSManaged public var state: String?
    //information for map or web view
    @NSManaged public var latitude: String?
    @NSManaged public var longitude: String?
    @NSManaged public var website_url: String?
    
    init(fromJson json:JSON) {
        let entity = NSEntityDescription.entity(forEntityName: "Brewery",
                                                in: CoreManager.shared.coreManagerContext)!
        super.init(entity: entity, insertInto: CoreManager.shared.coreManagerContext)
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
    //functions for get data about brewery
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
    //fileprivate functions
    fileprivate func configureInfoForDisplay(desc: String,
                                             info: String,
                                             shouldUnderlineInfo: Bool = false) -> NSAttributedString {
        let attributeForDesc = [ NSAttributedString.Key.foregroundColor: UIColor.textInfo ]
        let attributedDescString = NSMutableAttributedString(string: desc, attributes: attributeForDesc)
        
        var attributeForInfo: [NSAttributedString.Key : Any] = [ NSAttributedString.Key.foregroundColor: UIColor.textDesc ]
        
        if shouldUnderlineInfo {
            attributeForInfo[NSAttributedString.Key.underlineStyle] = NSUnderlineStyle.single.rawValue
        }
        
        let attributedInfoString = NSAttributedString(string: info, attributes: attributeForInfo)
        attributedDescString.append(attributedInfoString)

        return attributedDescString
    }
    
    //MARK: core data functions
    @nonobjc public func fetchRequest() -> NSFetchRequest<Brewery> {
        return NSFetchRequest<Brewery>(entityName: "Brewery")
    }
    
    private override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }
}
