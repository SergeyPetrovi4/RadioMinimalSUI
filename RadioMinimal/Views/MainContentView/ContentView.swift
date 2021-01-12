//
//  ContentView.swift
//  RadioMinimal
//
//  Created by Sergey Krasiuk on 09/12/2020.
//

import SwiftUI

struct ContentView: View {
    
//    var networkService = NetworkServiceProtocol()
    @ObservedObject var stationsViewModel = RadioItemsViewModel(networkService: NetworkManager())
    
    @State private var selectedItem: RadioItem?
    
    @State private var isDataFetched = false
    @State private var isAddNew = false
    @State private var isPlay = false
    
    init() {
        
        let mainColor = UIColor(red: 0.95, green: 0.92, blue: 0.89, alpha: 1.0)
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.largeTitleTextAttributes = [
            .font : UIFont.systemFont(ofSize: 30),
            NSAttributedString.Key.foregroundColor : UIColor.darkText
        ]

        appearance.titleTextAttributes = [
            .font : UIFont.systemFont(ofSize: 18),
            NSAttributedString.Key.foregroundColor : UIColor.darkText
        ]
        
        appearance.backgroundColor = mainColor
        
        UINavigationBar.appearance().standardAppearance = appearance
        UITableView.appearance().backgroundColor = mainColor
    }
        
    var body: some View {
                
        NavigationView(content: {
            ZStack {
                Color.background.edgesIgnoringSafeArea(.all)
                
                VStack(alignment: .center, spacing: nil, content: {
                    List {
                        ForEach(self.stationsViewModel.stations, id: \.id) { item in
                            RadioItemView(item: item, isSelected: self.selectedItem == item)
                                .onTapGesture {
                                    self.selectedItem = item
                                }
                                .listRowBackground(self.selectedItem == item ? Color.selectedRow : Color.background)
                        }
                    }
                    .listStyle(InsetListStyle())
                    .onAppear {
                        self.stationsViewModel.fetchStations()
                    }
                })
                                
                PlayControlView(isPlay: self.$isPlay, isAddNew: self.$isAddNew)
                    .padding(.trailing, 31)
                    .padding(.bottom, 31)
                .sheet(isPresented: $isAddNew, content: {
                    AddNewItemView.init()
                })
                .zIndex(1)
                
            }
            .navigationBarTitle("Stations")
            .alert(isPresented: self.$isDataFetched, content: {
                Alert(title: Text("Minimal Radio"),
                      message: Text("Fetching data error"),
                      dismissButton: .default(Text("Close")))
            })
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .previewDevice("iPhone 11")
//            ContentView()
//                .previewDevice("iPhone 8")
        }
    }
}
