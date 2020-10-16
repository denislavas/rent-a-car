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

typealias Event = () -> Void
class SearchViewController: UIViewController, UITableViewDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noDataLabel: UILabel!
    var favouriteButton: UIBarButtonItem!

    var viewModel: SearchViewModel
    var favoritesClicked: Event?
    var carSelected: ((CarData) -> Void)?

    init (viewModel: SearchViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.delegate = self
        setupViews()
    }

    func setupViews() {

        title = NSLocalizedString("Keyword Search", comment: "")

        // Bar Button
        favouriteButton = UIBarButtonItem()
        favouriteButton.title = NSLocalizedString("Favourites", comment: "")
        navigationItem.rightBarButtonItem = favouriteButton
        favouriteButton.target = self
        favouriteButton.action = #selector(pressed)

        // Table View
        searchBar.delegate = self
        tableView.dataSource = self
        tableView.delegate = self
        let nibName = UINib(nibName: "SearchCarTableViewCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: reuseIdentifier)
        tableView.separatorStyle = .none

        // No Data Label
        noDataLabel.text = NSLocalizedString("No data available", comment: "")
        noDataLabel.textAlignment = .center
    }

    @objc func pressed(sender: UIButton!) {
        favoritesClicked?()
    }
}

// MARK: - UITableViewDataSource

extension SearchViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return viewModel.listOfCars.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! SearchCarTableViewCell

        let car = viewModel.listOfCars[indexPath.row]

        // Configure cell image
        cell.carImageView.image = nil
        if let imageURL = URL(string: car.primaryImageURL) {
            cell.carImageView.af.setImage(withURL: imageURL)
        } else {
            cell.carImageView.image = UIImage(named: "noPhoto")
        }

        // Configure cell label
        cell.carLabel.text = car.name

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let carData = viewModel.listOfCars[indexPath.row]
        carSelected?(carData)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - UISearchBarDelegate

extension SearchViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked( _ searchBar: UISearchBar) {
        if let searchText = searchBar.text {
            viewModel.buttonClicked(searchText)
        }
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.textChanged(searchText)
    }

}

// MARK: - SearchViewModelDelegate

extension SearchViewController: SearchViewModelDelegate {
    func searchViewModel(_ viewModel: SearchViewModel, didFinishFetching list: [CarData]) {
        if list.count == 0 {
            tableView.isHidden = true
            noDataLabel.isHidden = false
        } else {
            tableView.isHidden = false
            noDataLabel.isHidden = true
        }
        tableView.reloadData()
    }

    func searchViewModel(_ viewModel: SearchViewModel, caughtError error: CarError) {
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
}


