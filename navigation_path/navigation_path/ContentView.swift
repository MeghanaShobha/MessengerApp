import SwiftUI
import Combine

class MyModelObject: ObservableObject {
    @Published var path: NavigationPath

    static func readSerializedData() -> Data? {
        UserDefaults.standard.data(forKey: "NavigationPath")
    }

    static func writeSerializedData(_ data: Data) {
        UserDefaults.standard.set(data, forKey: "NavigationPath")
    }

    init() {
        if let data = Self.readSerializedData() {
            do {
                let representation = try JSONDecoder().decode(
                    NavigationPath.CodableRepresentation.self,
                    from: data
                )
                self.path = NavigationPath(representation)
            } catch {
                self.path = NavigationPath()
            }
        } else {
            self.path = NavigationPath()
        }
    }

    func save() {
        guard let representation = path.codable else {
            return
        }

        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(representation)
            Self.writeSerializedData(data)
        } catch {
            print("Failed to save navigation path: \(error)")
        }
    }
}

struct ContentView: View {
    @StateObject private var model = MyModelObject()

    var body: some View {
        NavigationStack(path: $model.path) {
            VStack(spacing: 20) {
                Button("Show 32") {
                    model.path.append(32)
                }

                Button("Show 64") {
                    model.path.append(64)
                }

                Button("Show 32 then 64") {
                    model.path.append(32)
                    model.path.append(64)
                }

                Button("Save Path") {
                    model.save()
                }

                Button("Clear Path") {
                    model.path = NavigationPath()
                }
            }
            .navigationTitle("Navigation")
            .navigationDestination(for: Int.self) { number in
                Text("Number: \(number)")
                    .font(.largeTitle)
            }
        }
    }
}
#Preview {
    ContentView()
}
