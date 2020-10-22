//
//  Car.swift
//  RentACar
//
//  Created by Denislava Stoyanova on 2.09.20.
//  Copyright © 2020 Denislava Stoyanova. All rights reserved.
//

import Foundation

struct CarData: Decodable {
    var name: String
    var primaryImageURL: String
    var vehicleType: String
    var description: String
    
    enum RootKeys: String, CodingKey {
        case attributes = "attributes"
        case relationships = "relationships"
        
    }
    
    enum AttributesKeys: String, CodingKey {
        case name = "name"
        case primaryImageURL = "primary_image_url"
        case vehicleType = "display_vehicle_type"
        case description = "description_included"
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: RootKeys.self)
        
        let attributes = try container.nestedContainer(keyedBy: AttributesKeys.self, forKey: .attributes)
        name = try attributes.decode(String.self, forKey: .name)
        primaryImageURL = try attributes.decode(String.self, forKey: .primaryImageURL)
        vehicleType = try attributes.decode(String.self, forKey: .vehicleType)
        description = try attributes.decode(String.self, forKey: .description)
    
    }
}



