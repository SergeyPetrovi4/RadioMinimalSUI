//
//  PlayControlView.swift
//  RadioMinimal
//
//  Created by Sergey Krasiuk on 11/12/2020.
//

import SwiftUI

struct PlayControlView: View {
    
    @Binding var isPlay: Bool
    @Binding var isAddNew: Bool
    
    @State private var isAddNewButtonVisible = false
    @State private var scale: CGFloat = 0
    
    var body: some View {
        VStack(alignment: .trailing, content: {
            VStack(alignment: .center, spacing: 24, content: {
                
                if self.isAddNewButtonVisible {
                    // Show / Hide Add new item button
                    
                    Button(action: {
                        self.isAddNew.toggle()
                        self.isAddNewButtonVisible.toggle()
                        
                    }) {
                        
                        RoundedButton(title: nil,
                                      image: "plus",
                                      radius: 49.82,
                                      size: CGSize(width: 49.82, height: 49.82),
                                      titleColor: Color.lightOrange,
                                      backgroundColor: Color.button)
                            
                    }
                    .buttonStyle(PlainButtonStyle())
                    .scaleEffect(self.scale)
                    .onAppear(perform: {
                        let baseAnimation = Animation.easeInOut(duration: 0.05)
                        let repeated = baseAnimation.repeatCount(0)

                        return withAnimation(repeated) {
                            self.scale = 1
                        }
                    })
                }
                
                Button(action: {
//                    self.isPlay.toggle()
                    
                }) {
                    
                    RoundedButton(title: nil,
                                  image: "play.fill",
                                  radius: 21.37,
                                  size: CGSize(width: 68, height: 68),
                                  titleColor: Color.lightOrange,
                                  backgroundColor: Color.button)
                }
                .buttonStyle(PlainButtonStyle())
                .simultaneousGesture(
                      LongPressGesture().onEnded { _ in
                        self.isAddNewButtonVisible.toggle()
                      }
                )
            })
        })
        .edgesIgnoringSafeArea(.all)
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxHeight: .infinity, alignment: .bottomTrailing)
    }
}

struct PlayControlView_Previews: PreviewProvider {

    @State static var aaa: Bool = false

    static var previews: some View {
        PlayControlView(isPlay: $aaa, isAddNew: $aaa)
    }
}
