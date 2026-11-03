import SwiftUI
struct Recipe: Identifiable {
    let id: Int
    let name: String
    let cookingTime: Int
    let difficulty: String
    let ingredients: [String]
    let instructions: String
}
struct ContentView: View {
    let recipes = [
        Recipe(id: 1, name: "Pasta",cookingTime: 20, difficulty: "Easy", ingredients: ["Pasta", "Tomato", "Garlic", "Cheese"], instructions: "Boil the pasta. Prepare the tomato sauce with garlic. Mix the pasta with the sauce and add cheese."),
        Recipe(id: 2, name: "Pizza", cookingTime: 30, difficulty: "Medium", ingredients: ["Flour", "Tomato", "Cheese", "Olives"], instructions: "Prepare the dough. Add tomato sauce, cheese and olives. Bake until the crust becomes golden."),
        Recipe(id: 3, name: "Burger", cookingTime: 25, difficulty: "Easy", ingredients: ["Bun", "Patty", "Cheese", "Lettuce"], instructions: "Cook the patty. Toast the bun. Add cheese, lettuce and the patty. Assemble the burger."),
        Recipe(id: 4, name: "Salad", cookingTime: 10, difficulty: "Easy", ingredients: ["Lettuce", "Tomato", "Cucumber", "Carrot"], instructions: "Wash and chop all vegetables. Mix them together and add your favorite dressing."),
        Recipe(id: 5, name: "Pancakes", cookingTime: 15, difficulty: "Easy", ingredients: ["Flour", "Milk", "Egg", "Sugar"], instructions: "Mix all ingredients into a smooth batter. Pour the batter into a hot pan and cook both sides until golden.")
    ]
    @State private var searchText = ""
    @State private var favorites: Set<Int> = []
    var filteredRecipes: [Recipe] {
        if searchText.isEmpty {
            return recipes
        } else {
            return recipes.filter {
                $0.name.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    var body: some View {
        NavigationStack {
            List(filteredRecipes) { recipe in
                NavigationLink {
                    RecipeView(recipe: recipe, favorites: $favorites)
                } label: {
                    HStack(spacing: 15) {
                        Image(systemName: "fork.knife")
                            .font(.system(size: 35))
                            .frame(width: 50)
                        VStack(alignment: .leading, spacing: 5) {
                            Text(recipe.name)
                                .font(.headline)
                            Text("\(recipe.cookingTime) minutes • \(recipe.difficulty)")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                        Spacer()
                        if favorites.contains(recipe.id) {
                            Image(systemName: "heart.fill")
                                .foregroundStyle(.red)
                        }
                    }
                    .padding(.vertical, 5)
                }
            }
            .searchable(text: $searchText, prompt: "Search recipes")
            .navigationTitle("Recipes")
        }
    }
}
struct RecipeView: View {
    let recipe: Recipe
    @Binding var favorites: Set<Int>
    var isFavorite: Bool {
        favorites.contains(recipe.id)
    }
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Image(systemName: "fork.knife")
                    .font(.system(size: 80))
                    .frame(maxWidth: .infinity)
                HStack {
                    Text(recipe.name)
                        .font(.largeTitle.bold())
                    Spacer()
                    Button {
                        if favorites.contains(recipe.id) {
                            favorites.remove(recipe.id)
                        } else {
                            favorites.insert(recipe.id)
                        }
                    } label: {
                        Image(systemName: isFavorite ? "heart.fill" : "heart")
                            .font(.title)
                            .foregroundStyle(isFavorite ? .red : .primary)
                    }
                }
                HStack {
                    Label("\(recipe.cookingTime) min", systemImage: "clock")
                    Spacer()
                    Label(recipe.difficulty, systemImage: "chart.bar")
                }
                .font(.headline)
                Divider()
                Text("Ingredients")
                    .font(.title2.bold())
                ForEach(recipe.ingredients, id: \.self) { ingredient in
                    HStack {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundStyle(.green)
                        Text(ingredient)
                    }
                }
                Divider()
                Text("Instructions")
                    .font(.title2.bold())
                Text(recipe.instructions)
                    .font(.body)
            }
            .padding()
        }
        .navigationTitle(recipe.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}
#Preview {
    ContentView()
}
