//
//  AddChildrenView.swift
//  Datamanagement2
//
//  Created by Kyungyun Lee on 13/02/2022.
//

import SwiftUI

struct AddChildrenView: View {
    
    @State var word : String = ""
    @State var meaning : String = ""
    @State var isShowAlert : Bool = false
    @State var isClicked : Bool = false
    @State var searchText : String = ""
    
    
    @EnvironmentObject var itemModel : ItemModel
    
    var item : Item
    
    var searchItem : [Children] {
        if searchText.isEmpty {
            return item.children
        } else {
            return item.children.filter({$0.word!.contains(searchText)})
        }
    }
    
    var body: some View {
        ZStack {
            if item.children.count == 0 {
                NochildrenView()
            } else {
                    List {
                        ForEach(searchItem) {child in
                            WordListRowView(children: child)
                            .swipeActions(edge: .trailing, allowsFullSwipe: true, content: {
                                    Button(role: .destructive, action: {
                                        itemModel.deleteChildren(children: child, item: item)
                                    }, label: {
                                        Image(systemName: "trash.fill")
                                    })
                                    
                                    Button(action: {
                                        itemModel.favoriteChildren(item: item, children: child)
                                    }, label: {
                                        Image(systemName: "star.fill")
                                           
                                    })
                                    .tint(.green)
                                })
                            }
                        }
                    .listStyle(.plain)
                    .padding(.top, -10)
                    .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
                    .autocapitalization(.none)
                    }
                }
        
        .navigationBarTitle("\(item.group!)'s Words")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(trailing:
                                
        HStack {
            Button(action: {
                addChildren()
            }, label: {
                Image(systemName: "plus")
            })
            
            Button(action: {
                itemModel.shuffleChildren(item: item)
            }, label: {
                Image(systemName: "shuffle")
            })
                          
            NavigationLink(destination: FlashCardView(item: item)) {
                Image(systemName: "play.rectangle")
            }
            .disabled(item.children.isEmpty)
        })
    }
}

extension AddChildrenView  {
    
    func addChildren() {
        let alert = UIAlertController(title: "Saving word", message: "Type word and meaning 😀", preferredStyle: .alert)
        
        alert.addTextField { word in
            word.placeholder = "Type a word"
            word.keyboardType = .alphabet
        }
        
        alert.addTextField { meaning in
            meaning.placeholder = "a meaning of word"
        }
        
        let addfolderAction = UIAlertAction(title: "Add", style: .default, handler: {
            (_) in
            self.word = alert.textFields![0].text!
            self.meaning = alert.textFields![1].text!
            itemModel.addNewChildren(item: item, word: word, meaning: meaning)
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: {
            (_) in
        })
        
        alert.addAction(cancelAction)
        alert.addAction(addfolderAction)
        
        UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true, completion: nil)
    }
}

extension UIApplication {
    func dismissKeyboard() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
