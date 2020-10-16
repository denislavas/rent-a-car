//
//  FavouritesCoordinator.swift
//  RentACar
//
//  Created by Denislava Stoyanova on 13.10.20.
//  Copyright © 2020 Denislava Stoyanova. All rights reserved.
//

import Foundation
import UIKit

class FavouritesCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()

    private let apiManager: FavouritesService
    private let favouritesNavigationController = UINavigationController()
    var isClosed: Event?

    init(_ apiManager: FavouritesService) {
        self.apiManager = apiManager
    }

    func start() -> UIViewController {
        let favouritesController = favouritesViewController()
        favouritesNavigationController.viewControllers = [favouritesController]
        return favouritesNavigationController
    }

    func favouritesViewController() -> FavouritesViewController {

        let favouritesViewModel = FavouritesViewModel(apiManager: apiManager)
        let favouritesViewController = FavouritesViewController(viewModel: favouritesViewModel)

        favouritesViewController.closeClicked = { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.isClosed?()
        }

        favouritesViewController.favouriteCarSelected = { [weak self] carData in
            guard let strongSelf = self else { return }
            let selecedCarViewModel = SelecedCarViewModel(carData: carData)
            let selecedCarViewController = SelecedCarViewController(viewModel: selecedCarViewModel)
            strongSelf.favouritesNavigationController.pushViewController(selecedCarViewController, animated: true)
        }
        return favouritesViewController
    }
}
