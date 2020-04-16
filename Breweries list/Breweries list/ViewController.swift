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
    fileprivate var arrayOfBreweries = [Breweries]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //register table view cell
        let nib = UINib.init(nibName: "BreweriesTableViewCell", bundle: nil)
        breweriesTableView.register(nib, forCellReuseIdentifier: "BreweriesTableViewCell")
        API.shared.getAllBreweries { [weak self] (arrayOfBreweriesOptional) in
            if arrayOfBreweriesOptional != nil {
                self?.arrayOfBreweries = arrayOfBreweriesOptional!
                DispatchQueue.main.async {
                    self?.breweriesTableView.reloadData()
                }
            } else {
                print("❌error")
            }
        }
    }


}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfBreweries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BreweriesTableViewCell") as! BreweriesTableViewCell
        cell.setData()
        return cell
    }
    
    
}
