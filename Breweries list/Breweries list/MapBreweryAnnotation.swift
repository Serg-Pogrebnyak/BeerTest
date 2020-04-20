//
//  MapBreweryAnnotation.swift
//  Breweries list
//
//  Created by Sergey Pohrebnuak on 20.04.2020.
//  Copyright © 2020 Sergey Pohrebnuak. All rights reserved.
//

import MapKit

class MapBreweryAnnotation: NSObject, MKAnnotation {
    let title: String?
    let subtitle: String?
    let coordinate: CLLocationCoordinate2D

    init?(name: String?, address: String?, latitude: String?, longitude: String?) {
        guard   latitude != nil,
                longitude != nil,
                let latitude = Double(latitude!),
                let longitude = Double(longitude!)
        else {
            return nil
        }
        self.title = name
        self.subtitle = address
        self.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
