//
//  Order.swift
//  Cupcake2
//
//  Created by Meghana IOS on 29/09/26.
//
import SwiftUI
import Observation // both are frameworks

@Observable //observe the property changes in class
class Order: Identifiable { //unique id
    let id = UUID()
    static let types = ["Vanilla", "Chocolate", "Red Velvet", "Blueberry"]
    var type = 1
    var quantity = 1
    var specialRequestEnable = false{
        didSet {
            if specialRequestEnable == false {
                extraFrosting = false
                addSprinkles = false
            }
            else{
                if !extraFrosting && !addSprinkles {
                    addSprinkles = true
                }
                
            }
        }
    }
    var extraFrosting = false
    var addSprinkles = false
    var name = ""  //taking the input from user
    var setAddress = ""
    var city = ""
    var pin = ""
    var State = ""
    var Country = ""
    var ContactNumber = ""
    var ValidAddress: Bool {
        !name.isEmpty && !setAddress.isEmpty && !city.isEmpty && !pin.isEmpty && !State.isEmpty && !Country.isEmpty && !ContactNumber.isEmpty
    }
    var cost : Decimal {
        var cost = Decimal(quantity) * 5
        cost += Decimal(type) / 5
        if extraFrosting {
            cost += Decimal(quantity)
        }
        if addSprinkles {
            cost += Decimal(quantity) / 5
        }
        return cost
    }
}
