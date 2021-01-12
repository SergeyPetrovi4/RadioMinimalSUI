//
//  AddNewItemView.swift
//  RadioMinimal
//
//  Created by Sergey Krasiuk on 19/12/2020.
//

import SwiftUI

struct AddNewItemView: View {
    
//    @ObservedObject var networkManager = NetworkManager()
    
    @State private var title: String = ""
    @State private var genre: String = ""
    @State private var type: String = ""
    @State private var country: String = ""
    @State private var link: String = ""
    
    @State private var titles = [Title(id: 0, text: "Title"),
                                 Title(id: 1, text: "Genre"),
                                 Title(id: 2, text: "Type"),
                                 Title(id: 3, text: "Country"),
                                 Title(id: 4, text: "Link")]
    
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
                VStack(alignment: .center, spacing: 0, content: {
                    List {
                        ForEach(self.titles, id: \.id) { title in
                            ItemFieldView(title: title.text)
                                .padding(.top, 24)
                                .listRowBackground(Color.background)
                        }
                    }
                    .listStyle(InsetListStyle())
                    
                    HStack {
                        Button(action: {
//                            self.networkManager.fetch()
                            
                        }, label: {
                            
                            RoundedButton(title: "Add to list",
                                          image: nil,
                                          radius: 14,
                                          size: CGSize(width: CGFloat.infinity, height: 55),
                                          titleColor: Color.lightOrange,
                                          backgroundColor: Color.button)
                        })
                        .buttonStyle(PlainButtonStyle())
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 55, alignment: .center)
                        .padding(.leading, 24)
                        .padding(.trailing, 24)
                        .padding(.bottom, 32)
                    }
                    .background(Color.background)
                })
                .edgesIgnoringSafeArea(.all)
                .navigationBarTitle("Add new station")
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .leading)
        })
    }
}

struct AddNewItemView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewItemView()
    }
}
