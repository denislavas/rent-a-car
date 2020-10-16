//
//  File.swift
//  RentACar
//
//  Created by Denislava Stoyanova on 1.10.20.
//  Copyright © 2020 Denislava Stoyanova. All rights reserved.
//

import Foundation
import Alamofire

protocol EndPointType {
    
    var httpMethod: HTTPMethod { get }
    var urlParameters: [String: String] { get }
    var url: URL { get }
    var encoding: ParameterEncoding { get }
    
}

extension EndPointType {
    var httpMethod: HTTPMethod {
        return .get
    }
    var encoding: ParameterEncoding {
        return JSONEncoding.default
    }
}

struct RentalsEndpoint: EndPointType {
    
    var urlParameters: [String: String] {
        return ["filter[keywords]":keywords, "address":"texas"]
    }
    private let keywords: String
    
    init(_ keywords: String) {
        self.keywords = keywords
    }
    
    var url: URL {
        return URL(string: Constants.URL.baseURL + Constants.URL.rentalsPath)!
    }
}

struct RentalDetailsEndoint: EndPointType {

    let httpMethod: HTTPMethod = .post
    
    var urlParameters: [String : String] = [:]
    
    var url: URL {
        return URL(string: Constants.URL.baseURL + Constants.URL.detailsPath)!
    }
    //    let encoding: ParameterEncoding = JSONEncoding.default
}

