//
//  NochildrenView.swift
//  SelfDic
//
//  Created by Kyungyun Lee on 23/02/2022.
//

import SwiftUI

struct NochildrenView: View {
    var body: some View {
        VStack {
            Image(systemName: "sun.max.fill")
                .symbolRenderingMode(.multicolor)
                .font(.system(size: 100))
                .padding()
            Text("Add your words! 🥰")
                .font(.title.bold())
                .padding(.bottom, 8)
            Text("Let's start our journey! \nPress ' + ' button to add words")
                .multilineTextAlignment(.center)
                .padding()
        }
        .background(.clear)
    }
}

struct NochildrenView_Previews: PreviewProvider {
    static var previews: some View {
        NochildrenView()
    }
}
