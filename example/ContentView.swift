//
//  ContentView.swift
//  example
//
//  Created by Максим on 26.09.2020.
//  Copyright © 2020 SolisOrtum. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var whoIsThere = false
    @State var infoBonus = false
    @State var sliderValue = 50.0
    @State var targetValue = Int.random(in: 1...100)
    @State var point = 0
    @State var round = 1
    @State var skillRound = 0
    
    struct LabelStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
            .font(Font.custom("Avenir Next Condensed", size: 24))
            .modifier(Shadow())
            .foregroundColor(Color.blue)
        }
    }
    
    struct ValueStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .foregroundColor(Color.green)
                .modifier(Shadow())
                .font(Font.custom("Arial Rounded MT Bold", size: 24))
        }
    }
    //we can invoke parameters from other viewModifiers
    struct Shadow: ViewModifier {
        func body(content: Content) -> some View {
            return content
            .shadow(color: Color.black, radius: 1, x: 1.5, y: 1.5)
        }
    }
    
    var body: some View {
        
        VStack { //vertical stack - the main body of the app and vertical stack
            //HStack - horizontal stack
            //HStack our score and next round score
            Spacer()
            HStack {
                Text("Put the value as close as you can to: ").modifier(LabelStyle())
                Text("\(targetValue)").modifier(ValueStyle())
                    }
            //HStack glider
            Spacer()
            HStack{
                Spacer()
                Text("1").modifier(ValueStyle())
                Slider(value: $sliderValue, in: 1...100)
                Text("100").modifier(ValueStyle())
                Spacer()
            }
            HStack {
                Spacer()
            }
            Button(action: {
                print("Hi console!")
                self.whoIsThere = true
            }) {
                Text("Knock Knock")
            }
            .alert(isPresented: $whoIsThere) { () -> Alert in
                return Alert(title: Text("Anybody here`s?"), message: Text(
                        "Slider`s value is \(sliderValueRounded())\n" +
                            "You scored \(awarded()) points this round\n"),
                             dismissButton: .default(Text("Oke")){
                                self.point += self.awarded()
                                self.targetValue = Int.random(in: 1...100)
                                self.round += 1
                                self.skillRound += 1
                    })
            }.foregroundColor(Color.green).font(.headline).shadow(color: Color.black, radius: 1, x: 1.5, y: 1.5)
            Spacer()
            HStack{
                       Button(action: {
                           print("F")
                        self.restartGame()
                       }){
                           Text("RE:Start")
                }
                Spacer()
                VStack {
                    Text("Score:")
                    Text("Skill:")
                }
                VStack {
                    Text("\(point)").modifier(ValueStyle())
                    Text("\(skill())%").modifier(ValueStyle())
                }
                Spacer()
                VStack {
                    Text("Round:")
                    Text("Bonus")
                }
                VStack {
                    Text("\(round)").modifier(ValueStyle())
                    Text("still nil")
                }
                Spacer()
                NavigationLink(destination: AboutView()) {
                    Text("Info")
                }
                }.padding(.all, 20).modifier(Shadow()) // or .bottom + .top + .left + .right + 20
        }.background(Image("background"), alignment: .center)
        .navigationBarTitle("Mashiron")
        
    }
    func sliderValueRounded() -> Int {
        return Int(sliderValue.rounded())
    }
    func awarded() -> Int {
        let points = 100 - abs(targetValue - sliderValueRounded())
        var bonus: Int
        if points == 100 {
            bonus = 100
        }else if points >= 98 {
            bonus = 50
        }else{
            bonus = 0
        }
        return points + bonus
    }
    func skill() -> Int{
        if skillRound == 0 {
            return self.point / ( skillRound + 1 )
        }else{
            return self.point / skillRound
        }
    }
    func restartGame() {
        round = 1
        point = 0
        skillRound = 0
        targetValue = Int.random(in: 1...100)
        sliderValue = 50.0
    }
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        //launch in the dark mode(in dark mode we cant recognize our other labels with darkcolor)
        ContentView()
            .previewLayout(.fixed(width: 896, height: 414))
    }
}
}
