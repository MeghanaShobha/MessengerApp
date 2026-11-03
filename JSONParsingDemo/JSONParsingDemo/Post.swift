//
//  post.swift
//  JSONParsingDemo
//
//  Created by Meghana IOS on 14/10/26.
//

import Foundation

struct Post: Codable, Identifiable {
    let id: Int
    let name: String
    let username: String
    let email: String
}
