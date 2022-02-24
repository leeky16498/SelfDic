//
//  Datamanagement2App.swift
//  Datamanagement2
//
//  Created by Kyungyun Lee on 13/02/2022.
//

import SwiftUI

@main
struct SelfDicApp: App {
    
    @StateObject var itemModel : ItemModel = ItemModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(itemModel)
        }
    }
}
