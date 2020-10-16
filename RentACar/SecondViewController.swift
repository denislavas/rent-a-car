//
//  SecondViewController.swift
//  RentACar
//
//  Created by Denislava Stoyanova on 28.09.20.
//  Copyright © 2020 Denislava Stoyanova. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class SearchViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noDataLabel: UILabel!
    
    var viewModel: SecondViewModel
    
    init (viewModel: SecondViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let reuseIdentifier = "SecondCarTableViewCell"
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.secondViewModelDelegate = self
        setupViews()
    }
    
    func setupViews() {
        self.title = NSLocalizedString("Keyword Search", comment: "")
        searchBar.delegate = self
        tableView.dataSource = self
        tableView.delegate = self
        let nibName = UINib(nibName: reuseIdentifier, bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: reuseIdentifier)
        tableView.separatorStyle = .none
        noDataLabel.text = NSLocalizedString("No data available", comment: "")
        noDataLabel.textAlignment = .center
    }
}

extension SearchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return viewModel.listOfCars.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! SecondCarTableViewCell
        
        let car = viewModel.listOfCars[indexPath.row]
        
        if let imageURL = URL(string: car.primaryImageURL) {
            cell.carImageView.af.setImage(withURL: imageURL)
        } else {
            cell.carImageView.image = UIImage(named: "noPhoto")
        }
        cell.carLabel.text = car.name
        return cell
    }
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked( _ searchBar: UISearchBar) {
        viewModel.buttonClicked(searchBar)
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.textChanged(searchText)
    }
}

extension SearchViewController: SecondViewModelDelegate {
    func didNotFetchingCars(_ error: CarError) {
        tableView.isHidden = false
        noDataLabel.isHidden = false
        tableView.reloadData()
        let errorMessage = error.description
        let alertTitle = NSLocalizedString("Error", comment: "")
        let alertActionTitle = NSLocalizedString("OK", comment: "")
        let alert = UIAlertController(title: alertTitle, message: errorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: alertActionTitle, style: .default))
        present(alert, animated: true)
    }
    
    func didFinishFetchingCars(_ list: [CarData]) {
        if list.count == 0 {
            tableView.isHidden = true
            noDataLabel.isHidden = false
        } else {
            tableView.isHidden = false
            noDataLabel.isHidden = true
        }
        tableView.reloadData()
    }
}
