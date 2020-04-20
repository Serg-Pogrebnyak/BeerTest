//
//  MapVC.swift
//  Breweries list
//
//  Created by Sergey Pohrebnuak on 20.04.2020.
//  Copyright © 2020 Sergey Pohrebnuak. All rights reserved.
//

import UIKit
import MapKit

class MapVC: UIViewController {

    @IBOutlet fileprivate weak var mapView: MKMapView!
    
    fileprivate var regionAroundPoint: CLLocationDistance = 1000 // in meters
    
    var mapAnnotation: MapBreweryAnnotation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUINavigationBar()
        setWhiteBackButton()
        
        mapView.addAnnotation(mapAnnotation)
        let coordinateRegion = MKCoordinateRegion(center: mapAnnotation.coordinate,
                                                  latitudinalMeters: regionAroundPoint,
                                                  longitudinalMeters: regionAroundPoint)
        mapView.setRegion(coordinateRegion, animated: true)
    }

}
