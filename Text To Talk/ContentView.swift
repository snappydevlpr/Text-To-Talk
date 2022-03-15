//
//  ContentView.swift
//  Text To Talk
//
//  Created by Austin Suarez on 3/14/22.
//

import SwiftUI
import AVFoundation

struct ContentView: View {
    @State private var statement:String = "Enter Statement";
    @State private var speechImageState:String = "mute";
    @State private var playState:Bool = false;

    var body: some View {
        ZStack{
            Color("background")
                .ignoresSafeArea()
            VStack{
                TextEditor(text: $statement)
                   .padding()
                   .background(Color.white)
                   .foregroundColor(Color.black)
                   .frame(width: UIScreen.main.bounds.width-80, height: UIScreen.main.bounds.height-500)
                   .cornerRadius(25)
                Spacer()
                
                
                Image(speechImageState)
                    .resizable()
                    .frame(width: 100, height: 100, alignment: .center)
                Spacer()
                Button(action:{
                    playState = !playState;
                    if(playState){
                        speechImageState = "microphone";
                    }
                    else{
                        speechImageState = "mute";
                    }
                    
                    let utterance = AVSpeechUtterance(string: statement)
                    utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
                    utterance.rate = 0.5

                    let synthesizer = AVSpeechSynthesizer()
                    synthesizer.speak(utterance)
                }){
                    Text("Text to Talk")
                }
                .padding()
                .foregroundColor(Color.white)
                .buttonStyle(.bordered)
                .background(Color("accent"))
                .clipShape(Capsule())
            }
            .ignoresSafeArea()
            .padding()
        }
     
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
