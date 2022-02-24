//
//  WordListRowView.swift
//  Datamanagement2
//
//  Created by Kyungyun Lee on 14/02/2022.
//

import SwiftUI
import AVFoundation

struct WordListRowView: View {
    
    @EnvironmentObject var itemModel : ItemModel
    
    let children : Children
    
    @State var isSpeaked : Bool = false
    
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
                        .foregroundColor(.blue)
                        .font(.body)
                        .lineLimit(1)
                    
                    Button(action:  {
                        isSpeaked.toggle()
                        
                        speaker(text: children.word!)
                        
                        DispatchQueue.main.asyncAfter(deadline: .now()+1.5, execute: {
                            isSpeaked.toggle()
                        })
                        
                    }, label: {
                        Image(systemName: isSpeaked ? "speaker.wave.2.fill" : "speaker.fill")
                            .foregroundColor(.yellow)
                    })
                }
            }
        }//Hstack
        .buttonStyle(PlainButtonStyle())
    }
}

extension WordListRowView {
    
    func speaker(text : String) {
        let utterance = AVSpeechUtterance(string : text)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        utterance.rate = 0.4
        
        let synthesizer = AVSpeechSynthesizer()
        synthesizer.speak(utterance)
    }
    
}
//struct WordListRowView_Previews: PreviewProvider {
//
//    static var previews: some View {
//        WordListRowView()
//    }
//}
