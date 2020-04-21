//
//  MapButtonView.swift
//  Breweries list
//
//  Created by Sergey Pohrebnuak on 20.04.2020.
//  Copyright © 2020 Sergey Pohrebnuak. All rights reserved.
//

import UIKit

class MapButtonView: UIView {
    
    @IBOutlet fileprivate var contentView: UIView!
    @IBOutlet fileprivate weak var mapButton: UIButton!
    
    fileprivate var mapAnnotation: MapBreweryAnnotation!
    fileprivate weak var delegate: ShowBreweryInfoDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    @IBAction func didTapOnMapButton(_ sender: Any) {
        delegate?.showOnMap(annotation: mapAnnotation)
    }
    
    func setData(annotation: MapBreweryAnnotation, delegate: ShowBreweryInfoDelegate) {
        self.delegate = delegate
        self.mapAnnotation = annotation
    }
    
    fileprivate func commonInit() {
        Bundle.main.loadNibNamed("MapButtonView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        mapButton.backgroundColor = UIColor.ownGreen
        mapButton.tintColor = UIColor.white
        mapButton.layer.cornerRadius = 5.0
    }
}
