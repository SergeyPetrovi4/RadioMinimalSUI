//
//  ItemFieldView.swift
//  RadioMinimal
//
//  Created by Sergey Krasiuk on 24/12/2020.
//

import SwiftUI

struct ItemFieldView: View {
    
    @State private var text: String = ""
    @State var title: String = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12, content: {
            TextField(self.title, text: self.$text)
                .foregroundColor(.black)
                .font(.system(size: 16.3))
                .padding(.horizontal, 8)
        })
    }
}

struct ItemFieldView_Previews: PreviewProvider {
    static var previews: some View {
        ItemFieldView()
    }
}
