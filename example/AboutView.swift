//
//  AboutView.swift
//  example
//
//  Created by Максим on 14.10.2020.
//  Copyright © 2020 SolisOrtum. All rights reserved.
//

import SwiftUI

struct AboutView: View {
    
    let beige = Color(red: 255.0 / 255.0, green: 214.0 / 255.0, blue: 179.0 / 255.0)
    
    struct TextViews: ViewModifier {
        func body(content: Content) -> some View {
            return content
            .font(Font.custom("Arial Rounded MT Bold", size: 16))
            .foregroundColor(Color.blue)
                .padding(.bottom, 20)
                .padding(.leading, 60)
                .padding(.trailing, 60)
        }
    }
    
    struct Heading: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .font(Font.custom("Arial Rounded MT Bold", size: 30))
                .padding(.top, 20)
                .padding(.bottom, 20)
                .foregroundColor(Color.black)
        }
    }
    
    var body: some View {
        Group{
        VStack{
            Text("First app").modifier(Heading())
            Text("This is mashiro slider").modifier(TextViews())
            Text("The game, where u can earn mashiros points").modifier(TextViews())
        }.modifier(TextViews())
        .navigationBarTitle("About mashiron").modifier(Heading())
        .background(beige)
        }.background(Image("background"))
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView().previewLayout(.fixed(width: 896, height: 414))
    }
}
