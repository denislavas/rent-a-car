//
//  FavouritesViewController.swift
//  RentACar
//
//  Created by Denislava Stoyanova on 7.10.20.
//  Copyright © 2020 Denislava Stoyanova. All rights reserved.
//

import UIKit

class FavouritesViewController: UIViewController, UITableViewDelegate {

    @IBOutlet weak var favouritesTableView: UITableView!
    var closeButton: UIBarButtonItem!
    
    var viewModel: FavouritesViewModel
    var closeClicked: Event?
    var favouriteCarSelected: ((CarData) -> Void)?
    
    init(viewModel: FavouritesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupFavouritesView()
        viewModel.delegate = self
        viewModel.loadFavourites()
    }

    func setupFavouritesView() {
        
        title = NSLocalizedString("Favourites", comment: "")
        
        favouritesTableView.dataSource = self
        favouritesTableView.delegate = self
        let nibName = UINib(nibName: "SearchCarTableViewCell", bundle: nil)
        favouritesTableView.register(nibName, forCellReuseIdentifier: reuseIdentifier)
        favouritesTableView.separatorStyle = .none
        
        closeButton = UIBarButtonItem()
        closeButton.title = NSLocalizedString("Close", comment: "")
        navigationItem.leftBarButtonItem = closeButton
        closeButton.target = self
        closeButton.action = #selector(pressed)
    }
    
    @objc func pressed(sender: UIButton!) {
        closeClicked?()
    }
}

// MARK: - UITableViewDataSource

extension FavouritesViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.listOfFavourites.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! SearchCarTableViewCell

        let car = viewModel.listOfFavourites[indexPath.row]

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
        let carData = viewModel.listOfFavourites[indexPath.row]
        favouriteCarSelected?(carData)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - FavouritesViewModelDelegate

extension FavouritesViewController: FavouritesViewModelDelegate {

    func favouritesViewModel(_ viewModel: FavouritesViewModel, didFinishFetching list: [CarData]) {
        favouritesTableView.reloadData()
    }

    func favouritesViewModel(_ viewModel: FavouritesViewModel, caughtError error: CarError) {
        favouritesTableView.reloadData()
        let errorMessage = error.description
        let alertTitle = NSLocalizedString("Error", comment: "")
        let alertActionTitle = NSLocalizedString("OK", comment: "")
        let alert = UIAlertController(title: alertTitle, message: errorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: alertActionTitle, style: .default))
        present(alert, animated: true)
    }
}
