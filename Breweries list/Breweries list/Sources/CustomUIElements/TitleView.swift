//
//  TitleView.swift
//  Breweries list
//
//  Created by Sergey Pohrebnuak on 16.04.2020.
//  Copyright © 2020 Sergey Pohrebnuak. All rights reserved.
//

import UIKit

class TitleView: UIView {

    @IBOutlet fileprivate var contentView: UIView!
    @IBOutlet fileprivate weak var titleLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func setData(title: String) {
        titleLabel.text = title
    }
    
    fileprivate func commonInit() {
        Bundle.main.loadNibNamed("TitleView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        titleLabel.textColor = UIColor.titleCell
    }
}
