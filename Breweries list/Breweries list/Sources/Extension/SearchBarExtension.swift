//
//  SearchBarExtension.swift
//  Breweries list
//
//  Created by Sergey Pohrebnuak on 20.04.2020.
//  Copyright © 2020 Sergey Pohrebnuak. All rights reserved.
//

import UIKit

extension UISearchBar {
    func setClearBackgroundView() {
        let version = (UIDevice.current.systemVersion as NSString).floatValue
        let countOfSublayers = version < 13.0 ? 1 : 2
        let indexOfBackgroundSublayer = version < 13.0 ? 0 : 1

        guard   let firstSearchBarSubview = self.subviews.first,
                firstSearchBarSubview.subviews.count >= countOfSublayers
        else {return}
        let backgroundView = firstSearchBarSubview.subviews[indexOfBackgroundSublayer]
        backgroundView.layer.opacity = 0.0
        
    }
    
    func setSearchBarTextFieldColor(_ color: UIColor) {
        if #available(iOS 13.0, *) {
            guard   let firstSearchBarSubview = self.subviews.first,
                    firstSearchBarSubview.subviews.count >= 3,
                    let textField = firstSearchBarSubview.subviews[2].subviews.first
            else {return}

            textField.backgroundColor = color
        }
        if #available(iOS 12.0, *) {
            guard   let firstSearchBarSubview = self.subviews.first,
                    firstSearchBarSubview.subviews.count >= 2,
                    let textField = firstSearchBarSubview.subviews[1] as? UITextField
            else {return}

            textField.backgroundColor = color
        }
    }
}
