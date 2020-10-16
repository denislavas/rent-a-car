//
//  SelecedCarViewController.swift
//  RentACar
//
//  Created by Denislava Stoyanova on 12.10.20.
//  Copyright © 2020 Denislava Stoyanova. All rights reserved.
//

import UIKit
import AlamofireImage


class SelecedCarViewController: UIViewController {

    @IBOutlet weak var selectedCarImageView: UIImageView!
    @IBOutlet weak var selectedCarLabel: UILabel!

    var viewModel: SelecedCarViewModel

    init(viewModel: SelecedCarViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.delegate = self
        title = NSLocalizedString("Car", comment: "")
        viewModel.carSelected()
    }
}

extension SelecedCarViewController: SelecedCarViewModelDelegate {
    func selecedCarViewModel(_ viewModel: SelecedCarViewModel, showingCar: CarData) {
        selectedCarLabel.text = showingCar.name
        if let imageURL = URL(string: showingCar.primaryImageURL) {
            selectedCarImageView.af.setImage(withURL: imageURL)
        } else {
            selectedCarImageView.image = UIImage(named: "noPhoto")
        }
    }
}
