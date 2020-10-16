//
//  AppCoordinator.swift
//  RentACar
//
//  Created by Denislava Stoyanova on 14.10.20.
//  Copyright © 2020 Denislava Stoyanova. All rights reserved.
//

import Foundation
import UIKit



class AppCoordinator: Coordinator {

    var childCoordinators = [Coordinator]()
    var apiManager: APIManager
    var mainController = UIViewController()

    init() {
        apiManager = APIManager()
    }
    func start() -> UIViewController {
        let mainCoordinator = MainCoordinator(apiManager)
        add(child: mainCoordinator)

        mainCoordinator.favoritesFlowRequested = { [weak self] in
            self?.navigateToFavourites()
        }
        mainController = mainCoordinator.start()
        return mainController
//        showMain()
//        return tabBarController
    }

//    fileprivate func showMain() {
//        let mainCoordinator = MainCoordinator(apiManager)
//        add(child: mainCoordinator)
//        mainCoordinator.favoritesFlowRequested = { [weak self, weak mainCoordinator] in
//            self?.showFavorites()
//            self?.remove(child: mainCoordinator!)
//        }
//        let mainController = mainCoordinator.start()
//        tabBarController.viewControllers = [mainController]
//    }
//
//    fileprivate func showFavorites() {
//        let favouritesCoordinator = FavouritesCoordinator(apiManager)
//        add(child: favouritesCoordinator)
//        let favouritesViewController = favouritesCoordinator.start()
//        tabBarController.viewControllers = [favouritesViewController]
//        favouritesCoordinator.isClosed = { [weak self] in
//            guard let strongSelf = self else { return }
//            strongSelf.remove(child: favouritesCoordinator)
//            strongSelf.showMain()
//
//        }
//    }



    func navigateToFavourites() {
        let favouritesCoordinator = FavouritesCoordinator(apiManager)
        add(child: favouritesCoordinator)
        let favouritesViewController = favouritesCoordinator.start()
        mainController.present(favouritesViewController, animated: true)
        favouritesCoordinator.isClosed = { [weak self] in
            guard let strongSelf = self else { return }
            favouritesViewController.dismiss(animated: true)
            strongSelf.remove(child: favouritesCoordinator)
        }
    }

} 
