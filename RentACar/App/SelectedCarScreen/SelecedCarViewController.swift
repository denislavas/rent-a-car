//
//  SelecedCarViewController.swift
//  RentACar
//
//  Created by Denislava Stoyanova on 12.10.20.
//  Copyright © 2020 Denislava Stoyanova. All rights reserved.
//

import UIKit
import AlamofireImage
import ParallaxHeader


class SelecedCarViewController: UIViewController {


    @IBOutlet weak var heightConstraint: NSLayoutConstraint!

    var selectedCarImageView: UIImageView!
    @IBOutlet weak var selectedCarLabel: UILabel!
    @IBOutlet weak var scrView: UIScrollView!

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
        selectedCarImageView = UIImageView()
        viewModel.delegate = self
        title = NSLocalizedString("Car2", comment: "")
        viewModel.carSelected()

        selectedCarImageView.contentMode = .scaleAspectFill
        scrView.parallaxHeader.view = selectedCarImageView
        scrView.parallaxHeader.height = 400
        scrView.parallaxHeader.minimumHeight = 0
        scrView.parallaxHeader.mode = .topFill
        
//        self.view.setNeedsLayout()
//        self.view.layoutIfNeeded()
//        print("viewDidLoad ===> \(scrView.frame.size.height)")
//        print("content ===> \(scrView.contentSize.height)")
//        print("child     ", #function, scrView.frame.size.height)

    }

//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        
//        self.view.setNeedsLayout()
//        self.view.layoutIfNeeded()
//        print("viewDidAppear ===> \(scrView.frame.size.height)")
//        print("content ===> \(scrView.contentSize.height)")
//        print("child     ", #function, scrView.frame.size.height)
//        heightConstraint.constant = scrView.frame.size.height - scrView.parallaxHeader.height - 1
//    }
}

extension SelecedCarViewController: SelecedCarViewModelDelegate {
    func selecedCarViewModel(_ viewModel: SelecedCarViewModel, showingCar: CarData) {
        if showingCar.description == "" {
            selectedCarLabel.text = NSLocalizedString("No description available", comment: "")
        } else {
            selectedCarLabel.text = showingCar.description
        }
        if let imageURL = URL(string: showingCar.primaryImageURL) {
            selectedCarImageView.af.setImage(withURL: imageURL)
        } else {
            selectedCarImageView.image = UIImage(named: "noPhoto")
        }
    }
}


