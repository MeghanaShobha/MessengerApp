import SwiftUI

struct MissionView: View {
    let mission: Mission
    let astronauts: [String: Astronaut]
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Image(mission.image)
                    .resizable()
                    .scaledToFit()
                    .containerRelativeFrame(.horizontal) { width, _ in
                        width * 0.8
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.top)
                VStack(alignment: .leading, spacing: 10) {
                    Text("Mission Highlights")
                        .font(.title.bold())
                    Text(mission.description)
                }
                .padding(.horizontal)
                VStack(alignment: .leading, spacing: 10) {
                    Text("Crew")
                        .font(.title2.bold())
                    ForEach(mission.crew) { member in
                        if let astronaut = astronauts[member.name] {
                            NavigationLink {
                                AstronautView(astronaut: astronaut)
                            } label: {
                                HStack {
                                    Image(systemName: "person.circle.fill")
                                        .font(.largeTitle)
                                    VStack(alignment: .leading) {
                                        Text(astronaut.name)
                                            .font(.headline)
                                        Text(member.role)
                                            .foregroundStyle(.secondary)
                                    }
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .foregroundStyle(.secondary)
                                }
                                .padding(.vertical, 5)
                            }
                        }
                    }
                }
                .padding(.horizontal)
            }
            .padding(.bottom)
        }
        .background(Color.black)
        .navigationTitle(mission.displayName)
        .navigationBarTitleDisplayMode(.inline)
    }
}

