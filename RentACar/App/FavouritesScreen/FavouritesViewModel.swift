//
//  FavouritesViewModel.swift
//  RentACar
//
//  Created by Denislava Stoyanova on 8.10.20.
//  Copyright © 2020 Denislava Stoyanova. All rights reserved.
//

import Foundation

protocol FavouritesViewModelDelegate: class {
    func favouritesViewModel(_ viewModel: FavouritesViewModel, didFinishFetching list: [CarData])
    func favouritesViewModel(_ viewModel: FavouritesViewModel, caughtError error: CarError)
}
class FavouritesViewModel: NSObject {
    
    var listOfFavourites = [CarData]()
    
    weak var delegate: FavouritesViewModelDelegate?
    
    //    private var apiManager: APIManager
    var apiManager: FavouritesService
    
    init(apiManager: FavouritesService) {
        self.apiManager = apiManager
        super.init()
    }
    
    func loadFavourites() {
        apiManager.favorites { [weak self] (response) in
            guard let self = self else { return }
            switch response {
            case .success(let carResponse):
                print("Success")
                self.listOfFavourites = carResponse.data
                self.delegate?.favouritesViewModel(self, didFinishFetching: self.listOfFavourites)
            case .error(let error):
                print("`error`")
                self.listOfFavourites.removeAll()
                self.delegate?.favouritesViewModel(self, caughtError: error)
            }
        }
    }
}
