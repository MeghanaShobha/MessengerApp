import SwiftUI
import Observation

struct Activity: Identifiable, Codable, Equatable {
    var id = UUID()
    var title: String
    var description: String
    var completionCount: Int
}
@Observable
class Activities {
    var activities: [Activity] = [] {
        didSet {
            save()
        }
    }
    private let key = "Activities"
    init() {
        load()
    }
    private func save() {
        if let encoded = try? JSONEncoder().encode(activities) {
            UserDefaults.standard.set(encoded, forKey: key)
        }
    }
    private func load() {
        guard let data = UserDefaults.standard.data(forKey: key) else {
            return
        }

        if let decoded = try? JSONDecoder().decode([Activity].self, from: data) {
            activities = decoded
        }
    }
}
struct ContentView: View {
    @State private var data = Activities()
    @State private var showingAddActivity = false
    var body: some View {
        NavigationStack {
            List {
                ForEach(data.activities) { activity in
                    NavigationLink {
                        DetailView(activity: activity, data: data)
                    } label: {
                        HStack {
                            VStack(alignment: .leading, spacing: 5) {
                                Text(activity.title)
                                    .font(.headline)

                                Text(activity.description)
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                                    .lineLimit(2)
                            }

                            Spacer()

                            Text("\(activity.completionCount)")
                                .font(.title2)
                                .bold()
                        }
                    }
                }
                .onDelete { indexSet in
                    data.activities.remove(atOffsets: indexSet)
                }
            }
            .navigationTitle("My Habits")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
                }

                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showingAddActivity = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddActivity) {
                AddActivityView(data: data)
            }
        }
    }
}

struct AddActivityView: View {
    @Environment(\.dismiss) private var dismiss
    var data: Activities
    @State private var title = ""
    @State private var description = ""
    var body: some View {
        NavigationStack {
            Form {
                Section("Activity") {
                    TextField("Title", text: $title)

                    TextField("Description", text: $description, axis: .vertical)
                }

                Section {
                    Button("Save") {
                        let activity = Activity(
                            title: title,
                            description: description,
                            completionCount: 0
                        )

                        data.activities.append(activity)
                        print("it is save")
                        dismiss()
                    }
                    .disabled(title.isEmpty || description.isEmpty)
                }
            }
            .navigationTitle("Add Activity")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
}

struct DetailView: View {
    let activity: Activity
    var data: Activities
    var body: some View {
        VStack(spacing: 30) {
            Text(activity.title)
                .font(.largeTitle)
                .bold()
            Text(activity.description)
                .font(.body)
                .multilineTextAlignment(.center)
            VStack(spacing: 10) {
                Text("Completed")
                    .font(.headline)

                Text("\(activity.completionCount)")
                    .font(.system(size: 60))
                    .bold()
            }
            Button {
                var newActivity = activity
                newActivity.completionCount += 1

                if let index = data.activities.firstIndex(of: activity) {
                    data.activities[index] = newActivity
                }
            } label: {
                Label("Complete", systemImage: "checkmark.circle.fill")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.blue)
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
        }
        .padding()
        .navigationTitle(activity.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    ContentView()
}
