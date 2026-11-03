//
//  AddFoodView.swift
//  iCalories
//
//  Created by Meghana IOS on 07/10/26.
//

import Foundation
import SwiftUI

struct AddFoodView: View{
    @Environment (\.managedObjectContext) var managedObjectContext
    @Environment(\.dismiss) var dismiss
    
    @State private var name = ""
    @State private var calories:Double = 0
    var body:some View{
        Form{
            Section{
                TextField("Food name",text: $name)
                VStack{
                    Text("Calories: \(Int(calories))")
                    Slider(value: $calories,in: 0...500, step:10)
                }
                .padding()

                HStack{
                    Spacer()
                    Button("Submit"){
                        DataController().addFood(name: name, calories: calories, context: managedObjectContext)
                        dismiss()
                    }
                    Spacer()
                }
            }
        }
    }
}
struct AddFoodView_Previews: PreviewProvider {
    static var previews: some View {
        AddFoodView()
    }
}
