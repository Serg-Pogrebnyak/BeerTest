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
    fileprivate var arrayOfBreweries = [Brewery]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //configure navigation bar
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = UIColor.ownGreen
        //register table view cell
        let nib = UINib.init(nibName: "BreweriesTableViewCell", bundle: nil)
        breweriesTableView.register(nib, forCellReuseIdentifier: "BreweriesTableViewCell")
        //mockedData()
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
    
    func mockedData() {
        let brewery1 = (Brewery.init(name: "Almanac Beer Company",
                                     id: "34",
                                     updatedAt: "234",
                                     phone: "4159326531",
                                     webSite: "http://almanacbeer.com"))
        arrayOfBreweries.append(brewery1)
        let brewery2 = (Brewery.init(name: "Almanac Beer Company 2",
                                     id: "34",
                                     updatedAt: "234",
                                     phone: "4159326531",
                                     latitude: "djnfs",
                                     longitude: "sdflknsdf",
                                     country: "United States",
                                     state: "United States",
                                     city: "Alameda",
                                     street: "651B W Tower Ave"))
        arrayOfBreweries.append(brewery2)
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
        cell.configureCell(tableViewWidth: tableView.bounds.width, brewery: arrayOfBreweries[indexPath.row])
        return cell
    }
    
    
}
