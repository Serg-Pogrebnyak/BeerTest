//
//  UIViewControllerExtension.swift
//  Breweries list
//
//  Created by Sergey Pohrebnuak on 20.04.2020.
//  Copyright © 2020 Sergey Pohrebnuak. All rights reserved.
//

import UIKit

extension UIViewController {
    func setupUINavigationBar() {
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = UIColor.ownGreen
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
    
    func setWhiteBackButton () {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backButtonDidTap))
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationItem.leftBarButtonItem?.setTitleTextAttributes(textAttributes, for: .normal)
    }
    
    @objc fileprivate func backButtonDidTap() {
        self.navigationController?.popViewController(animated: true)
    }
}
