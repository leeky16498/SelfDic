//
//  Item.swift
//  Datamanagement2
//
//  Created by Kyungyun Lee on 13/02/2022.
//

import Foundation

struct Item : Codable, Identifiable {
    var id : String = UUID().uuidString
    var group : String? = nil
    var children : [Children] = []
}

struct Children : Codable, Identifiable  {
    var id : String = UUID().uuidString
    var isFavorite : Bool = false
    var word : String? = nil
    var meaning : String? = nil
}
