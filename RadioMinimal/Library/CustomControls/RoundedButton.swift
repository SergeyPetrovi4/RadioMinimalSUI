//
//  RoundedButton.swift
//  RadioMinimal
//
//  Created by Sergey Krasiuk on 23/12/2020.
//

import SwiftUI

struct RoundedButton: View {
    
    var title: String?
    var image: String?
    var radius: CGFloat = 16
    var size = CGSize(width: 55, height: 55)
    var titleColor = Color.lightOrange
    var backgroundColor = Color.blue
    
    var body: some View {
        ZStack(content: {
            RoundedRectangle(cornerRadius: self.radius, style: .continuous)
                .frame(width: self.size.width, height: self.size.height, alignment: .center)
                .foregroundColor(self.backgroundColor)
                .clipShape(RoundedRectangle(cornerRadius: self.radius, style: .continuous))
                .shadow(color: Color(UIColor.lightGray), radius: 8, x: 0, y: 6)
            
            if let text = self.title {
                Text(text)
                    .multilineTextAlignment(.center)
                    .font(.system(size: 18.3, weight: .medium, design: .default))
                    .foregroundColor(self.titleColor)
            }
            
            if let image = self.image {
                Image(systemName: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: self.size.width, height: 24, alignment: .center)
                    .foregroundColor(self.titleColor)
                    
            }
        })
    }
}

struct RoundedButton_Previews: PreviewProvider {
    static var previews: some View {
        RoundedButton()
    }
}
