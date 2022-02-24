//
//  HomeView.swift
//  Datamanagement2
//
//  Created by Kyungyun Lee on 14/02/2022.
//

import SwiftUI

struct HomeView: View {
    
    @State var folderName : String = ""
    @State var isBelled : Bool = false
    
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
                .listStyle(.plain)
            }
                
            .navigationViewStyle(StackNavigationViewStyle())
            .navigationTitle("SelfDic 📒")
            .navigationBarItems(trailing:
                                    HStack {
                Button(action: {
                    addFolderView()
                }, label: {
                    Image(systemName: "folder.badge.plus")
            })
                 Button(action: {
                     isBelled.toggle()
                     if isBelled == true {
                         UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                             if success {
                                 UserNotification()
                             }
                         }
                     } else {
                         UIApplication.shared.unregisterForRemoteNotifications()
                         print("iscanceled")
                     }
                  }, label: {
                      Image(systemName: isBelled ? "bell.fill" : "bell.slash.fill")
            })
                 .disabled(itemModel.items.count == 0)
            }
            )
            .navigationBarItems(leading: EditButton())
        }
    }
}

extension HomeView {
    
    func addFolderView() {
        let alert = UIAlertController(title: "Make your folder!", message: "Type a name of folder 🙂", preferredStyle: .alert)
        
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
        
        alert.addAction(cancelAction)
        alert.addAction(addfolderAction)
        
        UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true, completion: nil)
    }
}

extension HomeView {
    func UserNotification() {
        
        var randomWord = itemModel.makeRandomWords()
        
        let content = UNMutableNotificationContent()
        content.title = "1 Second recommended word"
        content.subtitle = "\(randomWord.0) \(randomWord.1)"
//        content.sound = UNNotificationSound.default

        // show this notification five seconds from now
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 60, repeats: false)
//        var dateComponents = DateComponents()
//        dateComponents.calendar = Calendar.current
//
//        dateComponents.weekday = 3  // Tuesday
//        dateComponents.hour = 3  // 14:00 hours
//
//        // Create the trigger as a repeating event.
//        let trigger = UNCalendarNotificationTrigger(
//                 dateMatching: dateComponents, repeats: true)

        // choose a random identifier
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        // add our notification request
        UNUserNotificationCenter.current().add(request) { (error) in
            if error != nil {
                print("Error")
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
