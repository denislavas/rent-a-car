//
//  CoordinatorProtocol.swift
//  RentACar
//
//  Created by Denislava Stoyanova on 12.10.20.
//  Copyright © 2020 Denislava Stoyanova. All rights reserved.
//

import Foundation
import UIKit

protocol Coordinator: class {
    func start() -> UIViewController
    func add(child: Coordinator)
    func remove(child: Coordinator)
    var childCoordinators: [Coordinator] { get set }
}

extension Coordinator {
    func add(child: Coordinator) {
        childCoordinators.append(child)
    }

    func remove(child: Coordinator) {
        childCoordinators = childCoordinators.filter { $0 !== child }
    }
}

//---------------------------------------------

class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()

    private let apiManager: RentalsService & FavouritesService
    private let navigationController = UINavigationController()
    
    var favoritesFlowRequested: Event?

    init(_ apiManager: APIManager) {
        self.apiManager = apiManager
    }

    public func start() -> UIViewController {
        let searchController = searchViewController()
        navigationController.viewControllers = [searchController]
        return navigationController
    }

    func searchViewController() -> SearchViewController {
        let searchViewModel = SearchViewModel(apiManager: apiManager)

        let searchViewController = SearchViewController(viewModel: searchViewModel)

        searchViewController.favoritesClicked = { [weak self] in
            self?.favoritesFlowRequested?()
        }

        searchViewController.carSelected = { [weak self] carData in
            self?.navigateToSelectedCar(carData: carData)
        }
        return searchViewController
    }
//
//    func navigateToFavourites() {
//        let favouritesCoordinator = FavouritesCoordinator(apiManager)
//        add(child: favouritesCoordinator)
//        let favouritesViewController = favouritesCoordinator.start()
//        navigationController.present(favouritesViewController, animated: true)
//        favouritesCoordinator.isClosed = { [weak self] in
//            guard let strongSelf = self else { return }
//            favouritesViewController.dismiss(animated: true)
//            strongSelf.remove(child: favouritesCoordinator)
//        }
//    }



    func navigateToSelectedCar(carData: CarData) {
        let selecedCarViewModel = SelecedCarViewModel(carData: carData)
        let selecedCarViewController = SelecedCarViewController(viewModel: selecedCarViewModel)
        navigationController.pushViewController(selecedCarViewController, animated: true)
    }
}





