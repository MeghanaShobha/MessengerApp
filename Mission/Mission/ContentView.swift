import SwiftUI
struct CrewRole: Codable, Identifiable {
    let name: String
    let role: String
    var id: String { name }
}
struct Mission: Codable, Identifiable {
    let id: Int
    let launchDATE: Date?
    let crew: [CrewRole]
    let Description: String
    var displayName: String {
        "Apollo \(id)"
    }
    var image: String {
        "\(id)"
    }
}
struct Astronaut: Codable {
    let id: String
    let name: String
    let description: String
}
extension Bundle {
    func decode<T: Codable>(_ file: String) -> T? {
        guard let url = url(forResource: file, withExtension: nil) else {
            print("Could not find \(file) in the app bundle.")
            return nil
        }
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            return try decoder.decode(T.self, from: data)
        } catch {
            print("Could not decode \(file): \(error)")
            return nil
        }
    }
}
struct ContentView: View {
    let missions: [Mission] = Bundle.main.decode("missions.json") ?? []
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json") ?? [:]
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: [
                    GridItem(.adaptive(minimum: 150))
                ]) {
                    ForEach(missions) { mission in
                        NavigationLink {
                            MissionView(mission: mission, astronauts: astronauts)
                        } label: {
                            VStack {
                                Image(mission.image)
                                    .resizable()
                                    .scaledToFit()
                                Text(mission.displayName)
                                    .font(.headline)
                                if let launchDate = mission.launchDATE {
                                    Text(launchDate.formatted(date: .abbreviated, time: .omitted))
                                        .font(.caption)
                                }
                            }
                            .padding()
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Moonshot")
        }
    }
}
//struct MissionView: View {
//    let mission: Mission
//    let astronauts: [String: Astronaut]
//    var body: some View {
//        ScrollView {
//            VStack(alignment: .leading, spacing: 20) {
//                Image(mission.image)
//                    .resizable()
//                    .scaledToFit()
//                    .containerRelativeFrame(.horizontal) { width, _ in
//                        width * 0.8
//                    }
//                    .frame(maxWidth: .infinity)
//                    .padding(.top)
//                VStack(alignment: .leading, spacing: 10) {
//                    Text("Mission Highlights")
//                        .font(.title.bold())
//                    Text(mission.description)
//                }
//                .padding(.horizontal)
//                VStack(alignment: .leading, spacing: 10) {
//                    Text("Crew")
//                        .font(.title2.bold())
//                    ForEach(mission.crew) { member in
//                        if let astronaut = astronauts[member.name] {
//                            NavigationLink {
//                                AstronautView(astronaut: astronaut)
//                            } label: {
//                                HStack {
//                                    Image(systemName: "person.circle.fill")
//                                        .font(.largeTitle)
//                                    VStack(alignment: .leading) {
//                                        Text(astronaut.name)
//                                            .font(.headline)
//                                        Text(member.role)
//                                            .foregroundStyle(.secondary)
//                                    }
//                                    Spacer()
//                                    Image(systemName: "chevron.right")
//                                        .foregroundStyle(.secondary)
//                                }
//                                .padding(.vertical, 5)
//                            }
//                        }
//                    }
//                }
//                .padding(.horizontal)
//            }
//            .padding(.bottom)
//        }
//        .background(Color.black)
//        .navigationTitle(mission.displayName)
//        .navigationBarTitleDisplayMode(.inline)
//    }
//}
//struct AstronautView: View {
//    let astronaut: Astronaut
//    var body: some View {
//        ScrollView {
//            VStack {
//                Image(astronaut.id)
//                    .resizable()
//                    .scaledToFit()
//                Text(astronaut.description)
//                    .padding()
//            }
//        }
//        .background(Color.black)
//        .navigationTitle(astronaut.name)
//        .navigationBarTitleDisplayMode(.inline)
//    }
//}
#Preview {
    ContentView()
}
