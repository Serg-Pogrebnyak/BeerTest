//
//  ListOfBreweriesVC.swift
//  Breweries list
//
//  Created by Sergey Pohrebnuak on 16.04.2020.
//  Copyright © 2020 Sergey Pohrebnuak. All rights reserved.
//

import UIKit
import SafariServices

class ListOfBreweriesVC: UIViewController {

    @IBOutlet fileprivate weak var searchBar: UISearchBar!
    @IBOutlet fileprivate weak var breweriesTableView: UITableView!
    fileprivate var tapOnTableViewGestureRecognizer: UITapGestureRecognizer!
    fileprivate var arrayOfBreweries = [Brewery]() {
        didSet {
            DispatchQueue.main.async {
                self.breweriesTableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    //MARK: - filepivate functions
    //MARK: API and local storage functions
    fileprivate func fetchAllDataFromAPI() {
        API.shared.getAllBreweries{ [weak self] (success) in
            if success {
                self?.fetchDataFromLocalStorage()
            }
        }
    }
    
    fileprivate func searchDataInAPI(text: String) {
        API.shared.searchBreweries(bysearch: text) {[weak self] (searchedBreweries) in
            guard searchedBreweries != nil else {return}
            self?.arrayOfBreweries = searchedBreweries!
            self?.breweriesTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
        }
    }
    
    fileprivate func fetchDataFromLocalStorage() {
        CoreManager.shared.coreManagerContext.perform { [weak self] in
            do {
                self?.arrayOfBreweries = try CoreManager.shared.coreManagerContext.fetch(Brewery.fetchRequest()) as! [Brewery]
                self?.breweriesTableView.reloadData()
            } catch {
                print("some error")
            }
        }
    }
    //MARK: UI functions
    fileprivate func setupUI() {
        self.view.backgroundColor = UIColor.ownGreen
        //configure UISearch bar
        searchBar.delegate = self
        searchBar.setClearBackgroundView()
        searchBar.setSearchBarTextFieldColor(UIColor.white)
        searchBar.placeholder = "Search"
        //configure navigation bar
        setupUINavigationBar()
        //register table view cell
        let nib = UINib.init(nibName: "BreweriesTableViewCell", bundle: nil)
        breweriesTableView.register(nib, forCellReuseIdentifier: "BreweriesTableViewCell")
        breweriesTableView.backgroundView = BackgroundTableView()
        
        tapOnTableViewGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(finishEnterText))
        breweriesTableView.addGestureRecognizer(tapOnTableViewGestureRecognizer)
        //get data
        arrayOfBreweries = CoreManager.shared.getBreweriesFromCoreData()
        fetchAllDataFromAPI()
    }
    
    @objc fileprivate func finishEnterText() {
        searchBar.endEditing(true)
        tapOnTableViewGestureRecognizer.isEnabled = false
    }
}

//MARK: - UITableViewDelegate
extension ListOfBreweriesVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
//MARK: - UITableViewDataSource
extension ListOfBreweriesVC: UITableViewDataSource {
    
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
//MARK: - ShowBreweryInfoDelegate
extension ListOfBreweriesVC: ShowBreweryInfoDelegate {
    func tapOnWebSiteLabel(url: URL) {
        finishEnterText()
        let config = SFSafariViewController.Configuration()
        config.entersReaderIfAvailable = true

        let vc = SFSafariViewController(url: url, configuration: config)
        present(vc, animated: true)
    }
    
    func showOnMap(annotation: MapBreweryAnnotation) {
        finishEnterText()
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let mapVC = storyBoard.instantiateViewController(withIdentifier: "MapVC") as! MapVC
        mapVC.mapAnnotation = annotation
        present(mapVC, animated: true)
    }
}
//MARK: - UISearchBarDelegate
extension ListOfBreweriesVC: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        tapOnTableViewGestureRecognizer.isEnabled = true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchDataInAPI(text: searchText)
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        finishEnterText()
        guard let searchText = searchBar.text else {return}
        searchDataInAPI(text: searchText)
    }
}
