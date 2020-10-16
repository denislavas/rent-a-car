//
//  SelecedCarViewModel.swift
//  RentACar
//
//  Created by Denislava Stoyanova on 12.10.20.
//  Copyright © 2020 Denislava Stoyanova. All rights reserved.
//

import Foundation

protocol SelecedCarViewModelDelegate: class {
    func selecedCarViewModel(_ viewModel: SelecedCarViewModel, showingCar: CarData)
}

class SelecedCarViewModel: NSObject {
    
    var carData: CarData
    
    weak var delegate: SelecedCarViewModelDelegate?
    
    init(carData: CarData) {
        self.carData = carData
        super.init()
    }
    
    func carSelected() {
        self.delegate?.selecedCarViewModel(self, showingCar: carData)
    }
}
