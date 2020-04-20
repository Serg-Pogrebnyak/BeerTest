//
//  InformationView.swift
//  Breweries list
//
//  Created by Sergey Pohrebnuak on 18.04.2020.
//  Copyright © 2020 Sergey Pohrebnuak. All rights reserved.
//

import UIKit

class InformationView: UIView {

    @IBOutlet fileprivate var contentView: UIView!
    @IBOutlet fileprivate weak var descriptionLabel: UILabel!
    
    fileprivate weak var delegate: ShowBreweryInfoDelegate?
    fileprivate var url: URL!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func setData(attributedInfo: NSAttributedString) {
        descriptionLabel.attributedText = attributedInfo
    }
    
    func setAsWebSite(webSite: NSAttributedString, delegate: ShowBreweryInfoDelegate, url: URL) {
        self.url = url
        self.delegate = delegate
        descriptionLabel.attributedText = webSite
        let fGuesture = UITapGestureRecognizer(target: self, action: #selector(didTapOnLabel))
        descriptionLabel.addGestureRecognizer(fGuesture)
        descriptionLabel.isUserInteractionEnabled = true
    }
    
    @objc fileprivate func didTapOnLabel() {
        guard url != nil else {return}
        delegate?.tapOnWebSiteLabel(url: url)
    }
    
    fileprivate func commonInit() {
        Bundle.main.loadNibNamed("InformationView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }

}
