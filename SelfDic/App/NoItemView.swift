//
//  NoItemView.swift
//  SelfDic
//
//  Created by Kyungyun Lee on 23/02/2022.
//

import SwiftUI

struct NoItemView: View {
    var body: some View {
        VStack {
            Image(systemName: "leaf.fill")
                .symbolRenderingMode(.multicolor)
                .font(.system(size: 100))
                .padding()
            Text("Add your study folder! 😉")
                .font(.title.bold())
                .padding(.bottom, 8)
            Text("Before explore your study, \nLet's add folders, first!")
                .multilineTextAlignment(.center)
                .padding()
        }
        .background(.clear)
    }
}

struct NoItemView_Previews: PreviewProvider {
    static var previews: some View {
        NoItemView()
    }
}
