//
//  FlashCardView.swift
//  Datamanagement2
//
//  Created by Kyungyun Lee on 23/02/2022.
//

import SwiftUI

struct FlashCardView: View {
    
    @EnvironmentObject var itemModel : ItemModel
    
    var item : Item
   
    @State var isGeneral : Bool = true
    @State var inputAnswer : String = ""
    @State var showAlert : Bool = false
    @State var isAnswer : Bool = false
    
    @State var randomWord : (String, String) = ("", "")
    
    var body: some View {
        VStack {
            
            HStack {
                if let group = item.group {
                    Text("Game with ' \(group) ' 🗂")
                        .font(.title3.bold())
                        .lineLimit(1)
                        .padding()
                        .background(
                            Color.yellow
                                .frame(height : 4)
                                .offset(y : 24)
                        )
                }
                
            }
            
            HStack {
                
                Button(action:  {
                    isGeneral = true
                    makeNewCard()
                }, label: {
                    Text(isGeneral ? "General 🔥" : "General")
                        .font(.headline)
                        .foregroundColor(isGeneral ? .white : .black)
                        .frame(width : 140, height : 50)
                        .background(isGeneral ? .blue : .gray)
                        .cornerRadius(10)
                        .padding()
                        
                })
                .shadow(color: .gray.opacity(0.5), radius: 3, x: 3, y: 3)
                
                Spacer()
                
                Button(action:  {
                    isGeneral = false
                    makeNewCard()
    
                }, label: {
                    Text(!isGeneral ? "Favorite 🔥" : "Favorite")
                        .font(.headline)
                        .foregroundColor(!isGeneral ? .white : .black)
                        .frame(width : 140, height : 50)
                        .multilineTextAlignment(.center)
                        .background(!isGeneral ? .blue : .gray)
                        .cornerRadius(10)
                        .padding()
                       
                })
                .disabled(item.children.filter({$0.isFavorite}).isEmpty)
                .shadow(color: .gray.opacity(0.5), radius: 3, x: 3, y: 3)
            }
            
            Text(randomWord.0)
                .font(.title2.bold())
                    .frame(maxWidth : .infinity)
                    .frame(height : UIScreen.main.bounds.height*0.33)
                    .multilineTextAlignment(.center)
                    .background(.ultraThinMaterial)
                    .cornerRadius(20)
                    .shadow(color: .gray.opacity(0.4), radius: 3, x: 3, y: 3)
                    .padding()
            
            TextField("What is the answer?", text: $inputAnswer)
                .frame(maxWidth : .infinity)
                .frame(height : 60)
                .font(.body)
                .multilineTextAlignment(.center)
                .autocapitalization(.none)
                .submitLabel(.done)
                .onSubmit {
                    if randomWord.1 == inputAnswer {
                        self.showAlert.toggle()
                        self.isAnswer = true
                        self.inputAnswer = ""
                    } else {
                        self.showAlert.toggle()
                        self.isAnswer = false
                        self.inputAnswer = ""
                    }
                }
            Divider()
                .padding(.horizontal)
                .padding(.vertical, -10)
    
            
            Button(action:  {
                if randomWord.1 == inputAnswer {
                    self.showAlert.toggle()
                    self.isAnswer = true
                    self.inputAnswer = ""
                } else {
                    self.showAlert.toggle()
                    self.isAnswer = false
                    self.inputAnswer = ""
                }
            }, label: {
                Label("Check", systemImage: "checkmark.rectangle.fill")
                    
                    .frame(maxWidth : .infinity)
                    .frame(height : 60)
                    .font(.headline)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .background(Color.green)
                    .cornerRadius(10)
                    .shadow(color: .gray.opacity(0.4), radius: 3, x: 3, y: 3)
                    .padding()
            })
            .alert(isPresented : $showAlert) {
                Alert(title: Text(isAnswer ? "Nice! that is answer!" : "Sorry, It was not answer.."), message: Text(isAnswer ? "You got an answer! Cool! 🥰" : "It's OK!, Keep studying! 😋"), dismissButton: .default(Text("OK")) {
                    makeNewCard()
                })
                
            }
            .disabled(inputAnswer.count == 0)
            
        } // vst
        .padding()
        .onAppear {
            makeNewCard()
        }
       
        .navigationTitle("Flashcard Game 🎲")
    }
}

extension FlashCardView {
    
    func makeNewCard() {
        if isGeneral == true {
            randomWord = itemModel.makeRandomChildren(item: item)
        } else {
            randomWord = itemModel.makeRandomFavoriteChildren(item: item)
        }
    }
    
}
