//
//  SecondViewModel.swift
//  RentACar
//
//  Created by Denislava Stoyanova on 1.10.20.
//  Copyright © 2020 Denislava Stoyanova. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage

protocol SearchViewModelDelegate: class {
    func searchViewModel(_ viewModel: SearchViewModel, didFinishFetching list: [CarData])
    func searchViewModel(_ viewModel: SearchViewModel, caughtError error: CarError)
}

class SearchViewModel: NSObject {
    
    var listOfCars = [CarData]()
    
    weak var delegate: SearchViewModelDelegate?
    
    var apiManager: RentalsService
    
    init(apiManager: RentalsService) {
        self.apiManager = apiManager
        super.init()
    }
    
    func buttonClicked( _ searchText: String) {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(SearchViewModel.loadData(text:)), object: nil)
        loadData(text: searchText)
    }
    
    func textChanged(_ searchText: String) {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(SearchViewModel.loadData(text:)), object: searchText)
        if searchText.trimmingCharacters(in: .whitespaces).count >= 3 {
            self.perform(#selector(SearchViewModel.loadData(text:)), with: nil, afterDelay: 2)
        }
    }
    
    @objc func loadData(text: String) {
        apiManager.rentals(searchTerm: text) { [weak self] (response) in
            guard let self = self else { return }
            switch response {
            case .success(let carResponse):
                self.listOfCars = carResponse.data
                self.delegate?.searchViewModel(self, didFinishFetching: self.listOfCars)
                
            case .error(let error):
                self.listOfCars.removeAll()
                self.delegate?.searchViewModel(self, caughtError: error)
            }
        }
    }
}
