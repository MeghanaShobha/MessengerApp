//
//  ContentView.swift
//  WordScramble
//
//  Created by Meghana IOS on 07/09/26.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var newWord = ""
    @State private var rootWord = ""
    var body: some View {
        NavigationStack{
            List{
                Section{
                    TextField("Enter your word", text: $newWord)
                        .textInputAutocapitalization(.never)
                }
                Section{
                    ForEach(usedWords, id: \.self){word in
                        HStack{
                            Image(systemName:"\(word.count).circle")
                            Text(word)
                        }
                    }
                }
            }
            .navigationTitle(rootWord)
            .onSubmit(addNewWord)
            .onAppear(perform: startGame)
        }
    }
    func addNewWord() {
        let answer = newWord
            .lowercased()
            .trimmingCharacters(in: .whitespacesAndNewlines)
        guard !answer.isEmpty else {return}
        guard answer.allSatisfy({ $0.isLetter }) else { return }
        guard let lastLetter = rootWord.last else {return}
        guard answer.first == lastLetter else {return}
        guard isOriginal(word: answer) else {return}
        usedWords.insert(answer, at: 0)
        newWord = ""
    }
    func isOriginal(word: String) -> Bool {
            !usedWords.contains(word)
    }
    func startGame() {
        guard let startWordsURL = Bundle.main.url(
            forResource: "start",
            withExtension: "txt"
        ) else {
            rootWord = "ex :- silkworm"
            return
        }
        guard let startWords = try? String(contentsOf: startWordsURL) else {
            rootWord = "silkworm"
            return
        }
        let allWords = startWords.components(separatedBy: "\n")
        rootWord = allWords.randomElement() ?? "silkworm"
    }
}
#Preview {
    ContentView()
}
