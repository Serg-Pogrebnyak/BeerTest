//
//  ViewController.swift
//  Breweries list
//
//  Created by Sergey Pohrebnuak on 16.04.2020.
//  Copyright © 2020 Sergey Pohrebnuak. All rights reserved.
//

import UIKit
import SafariServices

class ViewController: UIViewController {

    @IBOutlet fileprivate weak var searchBar: UISearchBar!
    @IBOutlet fileprivate weak var breweriesTableView: UITableView!
    fileprivate var tapOnTableViewGestureRecognizer: UITapGestureRecognizer!
    fileprivate var arrayOfBreweries = [Brewery]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.ownGreen
        //configure UISearch bar
        searchBar.delegate = self
        searchBar.setClearBackgroundView()
        searchBar.setSearchBarTextFieldColor(UIColor.white)
        //configure navigation bar
        setupUINavigationBar()
        //register table view cell
        let nib = UINib.init(nibName: "BreweriesTableViewCell", bundle: nil)
        breweriesTableView.register(nib, forCellReuseIdentifier: "BreweriesTableViewCell")
        
        tapOnTableViewGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(finishEnterText))
        breweriesTableView.addGestureRecognizer(tapOnTableViewGestureRecognizer)
        //get data
        arrayOfBreweries = CoreManager.shared.getBreweriesFromCoreData()
        fetchDataFromAPI()
    }
    
    fileprivate func fetchDataFromAPI(searchText: String? = nil) {
        API.shared.getAllBreweries(bysearch: searchText) { [weak self] (arrayOfBreweriesOptional) in
            if arrayOfBreweriesOptional != nil {
                self?.arrayOfBreweries = arrayOfBreweriesOptional!
                CoreManager.shared.saveContext()
                DispatchQueue.main.async {
                    self?.breweriesTableView.reloadData()
                }
            } else {
                print("❌error")
            }
        }
    }
    
    @objc fileprivate func finishEnterText() {
        searchBar.endEditing(true)
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
        guard indexPath.row < arrayOfBreweries.count else {return cell}
        cell.configureCell(tableViewWidth: tableView.bounds.width,
                           brewery: arrayOfBreweries[indexPath.row],
                           openMapDelegate: self)
        return cell
    }
    
    
}

extension ViewController: ShowBreweryInfoDelegate {
    func tapOnWebSiteLabel(url: URL) {
        tapOnTableViewGestureRecognizer.isEnabled = false
        searchBar.endEditing(true)
        let config = SFSafariViewController.Configuration()
        config.entersReaderIfAvailable = true

        let vc = SFSafariViewController(url: url, configuration: config)
        present(vc, animated: true)
    }
    
    func showOnMap(annotation: MapBreweryAnnotation) {
        tapOnTableViewGestureRecognizer.isEnabled = false
        searchBar.endEditing(true)
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let mapVC = storyBoard.instantiateViewController(withIdentifier: "MapVC") as! MapVC
        mapVC.mapAnnotation = annotation
        present(mapVC, animated: true)
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        tapOnTableViewGestureRecognizer.isEnabled = true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        fetchDataFromAPI(searchText: searchText)
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        tapOnTableViewGestureRecognizer.isEnabled = false
        fetchDataFromAPI(searchText: searchBar.text)
        self.searchBar.resignFirstResponder()
    }
}
