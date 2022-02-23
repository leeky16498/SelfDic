//
//  WordListRowView.swift
//  Datamanagement2
//
//  Created by Kyungyun Lee on 14/02/2022.
//

import SwiftUI

struct WordListRowView: View {
    
    @EnvironmentObject var itemModel : ItemModel
    
    let children : Children
    
    var body: some View {
        
        HStack {
            if let word = children.word {
                if let meaning = children.meaning {
                    Image(systemName: children.isFavorite ? "checkmark.circle.fill" : "checkmark.circle")
                        .foregroundColor(children.isFavorite ? .green : .gray)
                        .font(.headline)
                        .padding(.leading, 5)
                    Text(word)
                        .font(.headline)
                        .lineLimit(1)
                    Spacer()
                    Text(meaning)
                        .font(.body)
                        .lineLimit(1)
                }
            }
        }//Hstack
        
        }
    }
//struct WordListRowView_Previews: PreviewProvider {
//
//    static var previews: some View {
//        WordListRowView()
//    }
//}
