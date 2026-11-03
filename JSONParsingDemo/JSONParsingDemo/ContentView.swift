//
//  ContentView.swift
//  JSONParsingDemo
//
//  Created by Meghana IOS on 14/10/26.
//

import SwiftUI

struct ContentView: View {
    @State private var users: [Post] = []

    var body: some View {
        NavigationStack {
            List(users, id: \.id) { user in
                VStack(alignment: .leading, spacing: 5) {
                    Text(user.name)
                        .font(.headline)

                    Text(user.username)
                        .font(.subheadline)

                    Text(user.email)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
            .navigationTitle("Users")
            .onAppear {
                fetchUsers()
            }
        }
    }

    func fetchUsers() {
        let url = URL(string: "https://jsonplaceholder.typicode.com/users")!

        URLSession.shared.dataTask(with: url) { receivedData, response, receivedError in
            if let error = receivedError {
                print(error.localizedDescription)
                return
            }

            guard let data = receivedData else {
                return
            }

            do {
                let decodedUsers = try JSONDecoder().decode([Post].self, from: data)
                DispatchQueue.main.async {
                    users = decodedUsers
                }
            } catch {
                print(error)
            }
        }.resume()
    }
}

#Preview {
    ContentView()
}
