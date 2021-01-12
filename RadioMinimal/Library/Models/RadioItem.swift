//
//  RadioItem.swift
//  RadioMinimal
//
//  Created by Sergey Krasiuk on 15/12/2020.
//

import Foundation

struct RadioItem: Decodable, Equatable {
    
    var id: Int
    var title: String
    var genre: String
    var type: String
    var country: String
    var url: String
}
