//
//  CityTableViewController.swift
//  DemoTrie
//
//  Created by Gaurav Tiwari on 21/06/19.
//  Copyright © 2019 Gaurav Tiwari. All rights reserved.
//

import UIKit

class CityTableViewController: UIViewController, UISearchBarDelegate {
    @IBOutlet weak var citiesTableView: UITableView!
    @IBOutlet weak var citiesSearchBar: UISearchBar!
    var dataSource = CityTableViewDataSource()
    
    lazy var viewModel : CityTableViewModel = {
        let viewModel = CityTableViewModel(dataSource: dataSource, apiService: LocalServiceAPI.shared)
        self.citiesTableView.dataSource = dataSource
        return viewModel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getCityList()
    }

    private func getCityList(){
        Utilities.shared.showActivity(view: view)
        viewModel.getCityList(completion: {
            DispatchQueue.main.async {
                Utilities.shared.hideActivity()
                self.citiesTableView?.reloadData()
            }
        })
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "openMap" {
            if let indexPath = citiesTableView.indexPathForSelectedRow{
                viewModel.openMap(for: segue, indexPath: indexPath as NSIndexPath)
            }
        }
    }
    
    // MARK: - Search
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            getCityList()
            return
        }
        getCityListListWithWithSearchText(searchString:searchText)
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.citiesSearchBar.endEditing(true)
    }

    private func getCityListListWithWithSearchText(searchString: String){
        viewModel.getCityListListWithWithSearchText(searchString: searchString, completion: {
            DispatchQueue.main.async {
                self.citiesTableView.reloadData()
            }
        })
    }
}
