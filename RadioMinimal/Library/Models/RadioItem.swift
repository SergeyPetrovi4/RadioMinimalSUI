//
//  RadioItem.swift
//  RadioMinimal
//
//  Created by Sergey Krasiuk on 15/12/2020.
//

import Foundation

protocol RadioItemProtocol: Codable {
    
    var id: UUID { get }
    var title: String { get set }
    var genre: String { get set }
    var type: String { get set }
    var country: String { get set }
    var url: String { get set }
    
    init()
    init(id: UUID, title: String, genre: String, type: String, country: String, url: String)
}

extension RadioItemProtocol {
    
    init(id: UUID = UUID(), title: String, genre: String, type: String, country: String, url: String) {
        self.init()
        
        self.title = title
        self.genre = genre
        self.type = type
        self.country = self.country
        self.url = url
    }
}

struct RadioItem: Equatable, RadioItemProtocol {
    
    init() {
        self.id = UUID()
        self.title = ""
        self.genre = ""
        self.type = ""
        self.country = ""
        self.url = ""
    }
    
    var id: UUID
    var title: String
    var genre: String
    var type: String
    var country: String
    var url: String
}
