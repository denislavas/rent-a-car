//
//  Constant.swift
//  RentACar
//
//  Created by Denislava Stoyanova on 21.09.20.
//  Copyright © 2020 Denislava Stoyanova. All rights reserved.
//

import Foundation

enum Constants {
    
    enum URL {
        static let baseURL = "https://search.outdoorsy.co"
        static let rentalsPath = "/rentals"
        static let detailsPath = "/details"
    }
    
    enum CoordinatorKeys: String {
        case searchViewCoordinator
        case favouritesViewCoordinator
    }
    
    enum Nibs {
        static let searchViewController = "SearchViewController"
        static let favouritesViewController = "FavouritesViewController"
        static let subView2ViewController = "SubView2ViewController"
    }
}
//let baseURL = "https://search.outdoorsy.co"
//let path = "rentals"
let reuseIdentifier = "cellIdentifier"



