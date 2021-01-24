//
//  RadioItemView.swift
//  RadioMinimal
//
//  Created by Sergey Krasiuk on 11/12/2020.
//

import SwiftUI

struct RadioItemView: View {
    
    var item: RadioItem
    var isSelected = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4, content: {
            Text(self.item.title)
                .bold()
                .multilineTextAlignment(.leading)
                .font(.system(size: 16.3))
            
            Text("\(self.item.genre) (\(self.item.type), \(self.item.country))")
                .multilineTextAlignment(.leading)
                .foregroundColor(self.isSelected ? .black : Color(UIColor.darkGray))
                .font(.system(size: 14.4))
        })
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 63, maxHeight: 63, alignment: .leading)
        .contentShape(Rectangle())
    }
}

struct RadioItemView_Previews: PreviewProvider {
    static var previews: some View {
        RadioItemView(item: RadioItem(title: "Americas Country", genre: "Country, Rock", type: "Music", country: "USA", url: ""))
    }
}
