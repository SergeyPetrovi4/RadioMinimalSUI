//
//  AddNewitemViewModel.swift
//  RadioMinimal
//
//  Created by Sergey Krasiuk on 12/01/2021.
//

import Foundation

protocol NewItemProtocol {
    func save()
}

class AddNewitemViewModel: ObservableObject, NewItemProtocol {
    
    @Published var isAddedNewItem = false
    @Published var isLoading = true
    
    private var networkService: NetworkServiceProtocol!
    private var item: RadioItem!
    
    init(networkService: NetworkServiceProtocol = NetworkManager()) {
        self.networkService = networkService
        self.item = RadioItem()
    }
    
    var title: String = "" {
        didSet {
            self.item.title = self.title
        }
    }
    
    var genre: String = "" {
        didSet {
            self.item.genre = self.genre
        }
    }
    
    var type: String = "" {
        didSet {
            self.item.type = self.type
        }
    }
    
    var country: String = "" {
        didSet {
            self.item.country = self.country
        }
    }
    
    var url: String = "" {
        didSet {
            self.item.url = self.url
        }
    }
    
    // MARK: - NewItemProtocol
    
    func save() {
        
        debugPrint(self.item!)
        self.isLoading = true
        
        self.networkService.request(point: .append(self.item)) { (result: Result<RadioItem, Failure>) in
            
            self.isLoading = false
            switch result {
            case .success(_):
                self.isAddedNewItem = true
                debugPrint("[S]: New Station added")
            case .failure(_):
                debugPrint("[F]: Creating New Station Failed")
            }
        }
    }
}
