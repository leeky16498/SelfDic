//
//  ContentView.swift
//  Datamanagement2
//
//  Created by Kyungyun Lee on 13/02/2022.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var itemModel : ItemModel
    
    var body: some View {
        ZStack{
                HomeView()
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
