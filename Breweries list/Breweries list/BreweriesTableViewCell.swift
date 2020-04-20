//
//  BreweriesTableViewCell.swift
//  Breweries list
//
//  Created by Sergey Pohrebnuak on 16.04.2020.
//  Copyright © 2020 Sergey Pohrebnuak. All rights reserved.
//

import UIKit

class BreweriesTableViewCell: UITableViewCell {
    
    
    @IBOutlet fileprivate weak var fromSuperViewToBorderViewLeft: NSLayoutConstraint!
    @IBOutlet fileprivate weak var fromSuperViewToBorderViewRight: NSLayoutConstraint!
    @IBOutlet fileprivate weak var fromBorderViewToStackViewLeft: NSLayoutConstraint!
    @IBOutlet fileprivate weak var fromBorderViewToStackViewRight: NSLayoutConstraint!
    @IBOutlet fileprivate weak var borderView: UIView!
    @IBOutlet fileprivate weak var elementsStackView: UIStackView!
    
    func configureCell(tableViewWidth: CGFloat, brewery: Brewery, openMapDelegate: ShowOnMapDelegate?) {
        elementsStackView.removeAllArrangedSubviews()
        let frame = CGRect.init(x: 0,
                                y: 0,
                                width: getElementWidth(rootWidth: tableViewWidth),
                                height: 15)
        let titleView = TitleView(frame: frame)
        titleView.setData(title: brewery.getName())
        
        elementsStackView.addArrangedSubview(titleView)
        for inform in brewery.getInformationForDisplay() {
            let informationView = InformationView(frame: frame)
            informationView.setData(attributedInfo: inform)
            elementsStackView.addArrangedSubview(informationView)
        }
        
        if let mapAnnotation = brewery.getMapAnnottaion() {
            let mapButtonView = MapButtonView(frame: frame)
            mapButtonView.delegate = openMapDelegate
            mapButtonView.setData(annotation: mapAnnotation)
            elementsStackView.addArrangedSubview(mapButtonView)
        }
        
        
        borderView.layer.backgroundColor = UIColor.tableViewCellBackground.cgColor
        borderView.layer.borderColor = UIColor.ownGreen.cgColor
        borderView.layer.borderWidth = 1.0
        borderView.layer.cornerRadius = 10
        
    }
    
    fileprivate func getElementWidth(rootWidth: CGFloat) -> CGFloat {
        let elementWidth =  rootWidth -
                            fromSuperViewToBorderViewLeft.constant -
                            fromSuperViewToBorderViewRight.constant -
                            fromBorderViewToStackViewLeft.constant -
                            fromBorderViewToStackViewRight.constant
        return elementWidth
    }
    

}

extension UIStackView {
    
    func removeAllArrangedSubviews() {
        let removedSubviews = arrangedSubviews.reduce([]) { (allSubviews, subview) -> [UIView] in
            self.removeArrangedSubview(subview)
            return allSubviews + [subview]
        }
        
        NSLayoutConstraint.deactivate(removedSubviews.flatMap({ $0.constraints }))
        
        removedSubviews.forEach({ $0.removeFromSuperview() })
    }
}
