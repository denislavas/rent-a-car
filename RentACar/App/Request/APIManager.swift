//
//  APIManager.swift
//  RentACar
//
//  Created by Denislava Stoyanova on 1.10.20.
//  Copyright © 2020 Denislava Stoyanova. All rights reserved.
//

import Foundation
import Alamofire

enum Response<Value> {
    case success(Value)
    case error(CarError)
}

enum CarError: Error {
    case canNotProcessData
    case serverError(Error)
}

extension CarError {
    var description: String {
        switch self {
        case .canNotProcessData:
            return NSLocalizedString("Can not process data", comment: "")
        case .serverError(let error):
            return error.localizedDescription
        }
    }
}

protocol RentalsService {
    func rentals(searchTerm: String, completion: @escaping (Response<CarResponse>) -> Void)
}

protocol FavouritesService {
    func favorites(completion: @escaping (Response<CarResponse>) -> Void)
}

class APIManager {
    
    let sessionManager: Session
    
    //    private let sessionManager: Session
    
    init() {
        self.sessionManager = Session()
    }
    
    func request<ModelType> (type: EndPointType, completion: @escaping (Response<ModelType>) -> Void) where ModelType: Decodable {
        self.sessionManager.request(type.url, method: type.httpMethod, parameters: type.urlParameters)
            .validate()
            .responseJSON { data in
                switch data.result {
                case .success(_):
                    let decoder = JSONDecoder()
                    if let jsonData = data.data {
                        let result = try? decoder.decode(ModelType.self, from: jsonData)
                        if let data = result {
                            completion(Response.success(data))
                        } else {
                            completion(Response.error(.canNotProcessData))
                        }
                    }
                    break
                case .failure(let error):
                    completion(Response.error(.serverError(error)))
                    break
                }
            }
    }
    
   
   
}

extension APIManager: RentalsService {
    func rentals(searchTerm: String, completion: @escaping (Response<CarResponse>) -> Void)  {
        let endpoint = RentalsEndpoint(searchTerm)
        request(type: endpoint, completion: completion)
    }
    
}

extension APIManager: FavouritesService {
    func favorites(completion: @escaping (Response<CarResponse>) -> Void)  {
        let endpoint = RentalsEndpoint("Trail")
        request(type: endpoint, completion: completion)
    }
}

