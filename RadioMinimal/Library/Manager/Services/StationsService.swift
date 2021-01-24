//
//  GetStationsService.swift
//  RadioMinimal
//
//  Created by Sergey Krasiuk on 22/01/2021.
//

import Foundation

//typealias StationsResult = Result<[RadioItem], Failure>

enum StationsService {
    case stations
    case append(Body)
}

extension StationsService: EndPointProtocol {
    
    typealias Body = RadioItem
    
    var path: String {
        switch self {
        case .stations, .append(_):
            return "/stations"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .stations:
            return .get
        case .append(_):
            return .post
        }
    }
    
    var body: Body? {
        switch self {
        case .stations:
            return nil
        case .append(let item):
            return item
        }
    }
}
