//
//  Expense.swift
//  SwiftdataExample
//
//  Created by Meghana IOS on 09/10/26.
//

import Foundation
import SwiftData

@Model
class Expense{
    var meghanaName:String
    var meghanaDate:Date
    var meghanaValue:Double
//    @Attribute(originalName: "date")
//    var meghanaDate: Date
//    @Attribute(originalName: "name")
//    var meghanaName: String
//    @Attribute(originalName: "value")
//    var meghanaValue: Double
    init(meghanaName:String,meghanaDate:Date,meghanaValue:Double){
        self.meghanaName = meghanaName
        self.meghanaDate = meghanaDate
        self.meghanaValue = meghanaValue
    }
}

