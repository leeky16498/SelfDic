//
//  ItemModel.swift
//  Datamanagement2
//
//  Created by Kyungyun Lee on 13/02/2022.
//

import Foundation

class ItemModel : ObservableObject {
    
    @Published var items : [Item] = [] {
        didSet {
            saveItem()
        }
    }
    
    let itemsKey = "items_Key"
    
    init() {
        getItems()
    }
   
    func addNewFolder(text : String) {
        
        let newFolder = Item(group : text)
        items.append(newFolder)
        print(items)
    }
    
    func addNewChildren(item : Item, word : String, meaning : String) {
        
        if let index = items.firstIndex(where: {$0.id == item.id}) {
            let newChildren = Children(word : word, meaning : meaning)
            items[index].children.append(newChildren)
        }
    }
    
    func deleteItem(indexSet : IndexSet) {
        items.remove(atOffsets: indexSet)
    }
    
    func moveItem(from :IndexSet, to : Int) {
        items.move(fromOffsets: from, toOffset: to)
    }
    
    func deleteChildren(children : Children, item : Item) {
        if let index = items.firstIndex(where: {$0.id == item.id}) {
            items[index].children.removeAll(where: {$0.id == children.id})
        }
    }
    
    func deleteChildren1(item : Item, indexSet : IndexSet) {
        if let index = items.firstIndex(where: {$0.id == item.id}) {
            items[index].children.remove(atOffsets: indexSet)
        }
    }
    
    func favoriteChildren(item : Item, children : Children) {
        if let index = items.firstIndex(where: {$0.id == item.id}) {
            if let index1 = items[index].children.firstIndex(where: {$0.id == children.id}) {
                items[index].children[index1].isFavorite.toggle()
            }
        }
    }
    
    func makeRandomChildren(item : Item) -> (String, String) {
        
        let firstItem = ("", "")
        
        if let index = items.firstIndex(where: {$0.id == item.id}) {
            if let children = items[index].children.randomElement() {
                return (children.word!, children.meaning!)
            }
        }
        return firstItem
    }
    
    func makeRandomFavoriteChildren(item : Item) -> (String, String) {
        
        let firstItem = ("","")
        
        if let index = items.firstIndex(where: {$0.id == item.id}) {
            if let children = items[index].children.filter({$0.isFavorite == true}).randomElement() {
                return (children.word!, children.meaning!)
            }
        }
        return firstItem
    }
    
    func saveItem() {
        if let encodedData = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(encodedData, forKey: itemsKey)
        }
    }
    
    func getItems() {
        guard
            let data = UserDefaults.standard.data(forKey: itemsKey),
            let savedItems = try? JSONDecoder().decode([Item].self, from: data)
        else {return}
        
        self.items = savedItems
    }
    
    func shuffleChildren(item : Item){
        if let index = items.firstIndex(where: {$0.id == item.id}) {
            items[index].children.shuffle()
        }
    }
    
    func childrenNumberCheck(item : Item) -> Int {
        
        if let index = items.firstIndex(where: {$0.id == item.id}) {
            print(items[index].children.count)
            return items[index].children.count
        }
        return 0
    }
    
//    func makeRandomWords() -> (String, String) {
//        
//        var childrens : [Children] = []
//        var children : Children
//        var randomNotification = ("There is no word yet,", "Let's start study now!")
//        
//        for value in items {
//            for value in value.children {
//                childrens.append(value)
//            }
//        }
//        
//        if let children = childrens.randomElement() {
//            if let word = children.word {
//                if let meaning = children.meaning {
//                    randomNotification = (word, meaning)
//                }
//            }
//        }
//        return randomNotification
//    }
    
}
