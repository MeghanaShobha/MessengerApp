//
//  ContentView.swift
//  JSONdemo1
//
//  Created by Meghana IOS on 19/10/26.
//


import SwiftUI

struct ContentView: View {
    @State private var books: [Book] = []

    var body: some View {
        NavigationStack {
            List(books) { book in
                VStack(alignment: .leading, spacing: 5) {
                    Text(book.title)
                        .font(.headline)

                    Text(book.authors.map { $0.name }.joined(separator: ", "))
                        .font(.subheadline)

                    Text("Languages: \(book.languages.joined(separator: ", "))")
                        .font(.caption)
                        .foregroundStyle(.secondary)

//                    Text("Downloads: \(book.downloadCount)")
//                        .font(.caption)
//                        .foregroundStyle(.secondary)
                    
                      Text("subjects: \(book.subjects)")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    
                    
                }
                .padding(.vertical, 4)
            }
            .navigationTitle("Books")
            .onAppear {
                fetchBooks()
            }
        }
    }

    func fetchBooks() {
        let url = URL(string: "https://gutendex.com/books/")!

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }

            guard let data = data else {
                return
            }

            do {
                let decodedResponse = try JSONDecoder().decode(BookResponse.self, from: data)

                DispatchQueue.main.async {
                    books = decodedResponse.results
                }
            } catch {
                print(error)
            }
        }.resume()
    }
}

struct BookResponse: Decodable {
    let results: [Book]
}

struct Book: Decodable, Identifiable {
    let id: Int
    let title: String
    let authors: [Author]
    let languages: [String]
//    let downloadCount: Int
    let subjects: [String]

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case authors
        case languages
//        case downloadCount = "download_count"
        case subjects
    }
}

struct Author: Decodable {
    let name: String
}

#Preview {
    ContentView()
}
