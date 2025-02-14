//
//  RadioItemsViewModel.swift
//  RadioMinimal
//
//  Created by Sergey Krasiuk on 28/12/2020.
//

import Foundation

protocol RadioItemsViewModelProtocol {
    func fetchStations()
}

class RadioItemsViewModel: ObservableObject, RadioItemsViewModelProtocol {

    private var networkService: NetworkServiceProtocol!
    private var task: AnyCancellable?
    
    @Published var stations = [RadioItem]()    

    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    // MARK: - RadioItemsViewModelProtocol
    
    func fetchStations() {
        
        self.networkService.request(url: .stations, method: .get, model: [RadioItem].self) { (result) in
            switch result {
            case .success(let stations):
                self.stations = stations
                
            case .failure(let error):
                debugPrint(error.localizedDescription)
            }
        }
    }
}

