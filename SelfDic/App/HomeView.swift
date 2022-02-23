//
//  HomeView.swift
//  Datamanagement2
//
//  Created by Kyungyun Lee on 14/02/2022.
//

import SwiftUI

struct HomeView: View {
    
    @State var folderName : String = ""
    
    @EnvironmentObject var itemModel : ItemModel
    
    var body: some View {
        NavigationView{
            ZStack {
                if itemModel.items.count == 0 {
                    NoItemView()
                }
                List{
                    ForEach(itemModel.items) {item in
                        if let group = item.group {
                            NavigationLink(destination: {
                                AddChildrenView(item : item)
                            }, label: {
                                HStack{
                                    Image(systemName: "folder")
                                        .foregroundColor(.yellow)
                                    Text(group)
                                        .font(.headline)
                                        .lineLimit(1)
                                }
                            })
                        }
                    }
                    .onMove(perform: itemModel.moveItem)
                    .onDelete(perform: itemModel.deleteItem)
                }
                .id(UUID())
                .listStyle(.plain)
            }
                
            .navigationViewStyle(StackNavigationViewStyle())
            .navigationTitle("SelfDic 📒")
            .navigationBarItems(trailing:
                Button(action: {
                    addFolderView()
                }, label: {
                    Image(systemName: "folder.badge.plus")
            }))
            .navigationBarItems(leading: EditButton())
        }
    }
}

extension HomeView {
    
    func addFolderView() {
        let alert = UIAlertController(title: "Saving folder", message: "Type a name of folder 🙂", preferredStyle: .alert)
        
        alert.addTextField { name in
            name.placeholder = "folder's name"
        }
        
        let addfolderAction = UIAlertAction(title: "Add", style: .default, handler: {
            (_) in
            self.folderName = alert.textFields![0].text!
            itemModel.addNewFolder(text: folderName)
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: {
            (_) in
        })
        alert.addAction(addfolderAction)
        alert.addAction(cancelAction)
        
        UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true, completion: nil)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
