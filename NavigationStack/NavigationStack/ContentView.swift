//
//  ContentView.swift
//  NavigationStack
//
//  Created by Meghana IOS on 09/09/26.
//

import SwiftUI
struct DestinationView: View {
    var body: some View {
        NavigationStack {
            NavigationLink {
                ColorDetail(color: .mint, text: "Mint")
            } label: {
                Text("Mint")
            }
            
            NavigationLink {
                ColorDetail(color: .red, text: "Red")
            } label: {
                Text("Red")
            }
        }
    }
}
struct ColorDetail: View {
    var color: Color
    var text: String
    var body: some View {
        VStack {
            Text(text)
            color
         }
    }
}
struct ValueView: View {
    private var recipes : [Recipe] = [.applePie, .chocolateCake]
    var body: some View {
        NavigationStack{
            List{
                NavigationLink("Mint",value:Color.mint)
                NavigationLink("Red",value:Color.red)
                ForEach(recipes){
                    recipe in NavigationLink(recipe.description, value: recipe)
                }
                
            }
            .navigationDestination(for: Color.self){
                color in ColorDetail(color: color,text:color.description)
            }
            .navigationDestination(for: Recipe.self){
                recipe in RecipeDetailView(recipe: recipe)
            }
        }
    }
}
struct RecipeDetailView: View {
    var recipe:Recipe
    var body: some View {
        Text(recipe.description)
    }
}
enum Recipe:Identifiable,Hashable,Codable{
    case applePie
    case chocolateCake
    var id :Self{self}
    var description:String{
        switch self {
        case .applePie:
            return "Apple Pie"
        case .chocolateCake:
            return "Chocolate Cake"
        }
    }
}
