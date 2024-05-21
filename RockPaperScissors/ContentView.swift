//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Жанибек Асылбек on 22.10.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var items = ["Rock", "Paper" , "Scissors"]
    @State private var appChoice = Int.random(in: 0...2)
    @State private var winOrLose = Bool.random()
    @State private var scoreCounter = 0
    @State private var counter = 0
    @State private var gameOver = false
    
    var body: some View {
        ZStack{
            VStack(spacing: 0){
                Color.purple
                    .ignoresSafeArea()
                
                LinearGradient(colors: [.purple, .green], startPoint: .top, endPoint: .bottom)
                Color.green
                Color.green
                LinearGradient(colors: [.green, .purple], startPoint: .top, endPoint: .bottom)
                
                Color.purple
                    .ignoresSafeArea()
            }
            VStack {
                
                Spacer()
                
                Text("Your score is \(scoreCounter)")
                    .foregroundColor(.white)
                    .font(.largeTitle.weight(.semibold))
                
                Image(items[appChoice])
                    .setImage()
                Text(winOrLose ? "Win" : "Lose")
                    .foregroundColor(.primary)
                    .font(.largeTitle.weight(.semibold))
                HStack{
                    ForEach(0..<3) { number in
                        Button{
                            play(number)
                        } label:{
                            Image(items[number])
                                .setImage()
                          }
                    }
                }
                
                Spacer()
                
                }
            .alert("Game over", isPresented: $gameOver){
                Button ("Replay", action: reset)
            } message: {
                Text("Your score is \(scoreCounter)!")
            }
        }
    }
    
    func reset(){
        appChoice = Int.random(in: 0...2)
        winOrLose.toggle()
        scoreCounter = 0
    }
    
    func nextRound(){
        appChoice = Int.random(in: 0...2)
        winOrLose.toggle()
    }
    
    func play(_ number: Int) {
        counter += 1
        if appChoice == 0 && winOrLose && number == 1{
            scoreCounter += 1
        }else if appChoice == 0 && !winOrLose && number == 2{
            scoreCounter += 1
        }else if appChoice == 1 && winOrLose && number == 2{
            scoreCounter += 1
        }else if appChoice == 1 && !winOrLose && number == 0{
            scoreCounter += 1
        }else if appChoice == 2 && winOrLose && number == 0{
            scoreCounter += 1
        }else if appChoice == 2 && !winOrLose && number == 1{
            scoreCounter += 1
        }else{
            scoreCounter -= 1
        }
        
        if scoreCounter < 0{
            scoreCounter = 0
        }
        
        if counter % 10 == 0{
            gameOver = true
        }
        
        nextRound()
    }
    
}

struct ItemImage: ViewModifier {
    func body(content: Content) -> some View {
        content
            .clipShape(Circle())
            .shadow(radius: 15)
            .imageScale(.large)
        
    }
}

extension View {
    func setImage() -> some View{
        modifier(ItemImage())
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
