//
//  ShowBreweryInfoDelegate.swift
//  Breweries list
//
//  Created by Sergey Pohrebnuak on 21.04.2020.
//  Copyright © 2020 Sergey Pohrebnuak. All rights reserved.
//

import UIKit

protocol ShowBreweryInfoDelegate: class {
    func showOnMap(annotation: MapBreweryAnnotation)
    func tapOnWebSiteLabel(url: URL)
}
