//
//  SecondCarTableViewCell.swift
//  RentACar
//
//  Created by Denislava Stoyanova on 21.09.20.
//  Copyright © 2020 Denislava Stoyanova. All rights reserved.
//

import UIKit

class SearchCarTableViewCell: UITableViewCell {
    
    @IBOutlet weak var carImageView: UIImageView!
    @IBOutlet weak var carLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
            
        carImageView.clipsToBounds = true
        carImageView.layer.cornerRadius = 5
    }
    
}
