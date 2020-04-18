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
    
    func setData(tableViewWidth: CGFloat) {
        let frame = CGRect.init(x: 0,
                                y: 0,
                                width: getElementWidth(rootWidth: tableViewWidth),
                                height: 17)
        let titleView = TitleView.init(frame: frame)
        self.elementsStackView.addSubview(titleView)
        
        
        borderView.layer.backgroundColor = UIColor.tableViewCellBackground.cgColor
        borderView.layer.borderColor = UIColor.ownGreen.cgColor
        borderView.layer.borderWidth = 1.5
        borderView.layer.cornerRadius = 10
        
    }
    
    override func layoutIfNeeded() {
        
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
