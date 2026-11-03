//
//  ThirdView.swift
//  GuessTheFlag
//
//  Created by Meghana IOS on 02/09/26.
//

import SwiftUI

struct ThirdView: View {
    @State private var countries = [
        "Estonia",
        "France",
        "Germany",
        "Ireland",
        "Italy",
        "Nigeria",
        "Poland",
        "Spain",
        "UK",
        "Ukraine",
        "US"
    ].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var scoreTitle = ""
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [.blue, .white],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag of")
                        .foregroundStyle(.black)
                    Text(countries[correctAnswer])
                        .foregroundStyle(.black)
                        .font(.largeTitle)
                }
                ForEach(0..<3, id: \.self) { number in
                    Button {
                        flagTapped(number)
                    } label: {
                        Image(countries[number])
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 100)
                    }
                }
            }
        }
        .navigationTitle("Guess the Flag")
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is ?")
        }
    }
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
        } else {
            scoreTitle = "Wrong"
        }
        showingScore = true
    }
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

#Preview {
    ThirdView()
}
