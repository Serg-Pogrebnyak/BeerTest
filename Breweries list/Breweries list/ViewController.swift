//
//  ViewController.swift
//  Breweries list
//
//  Created by Sergey Pohrebnuak on 16.04.2020.
//  Copyright © 2020 Sergey Pohrebnuak. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet fileprivate weak var breweriesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //register table view cell
        let nib = UINib.init(nibName: "BreweriesTableViewCell", bundle: nil)
        breweriesTableView.register(nib, forCellReuseIdentifier: "BreweriesTableViewCell")
    }


}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BreweriesTableViewCell") as! BreweriesTableViewCell
        cell.setData()
        return cell
    }
    
    
}
