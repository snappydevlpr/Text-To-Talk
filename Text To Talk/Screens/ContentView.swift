//
//  ContentView.swift
//  Text To Talk
//
//  Created by Austin Suarez on 3/14/22.
//

import SwiftUI
import AVFoundation


extension Animation {
    func animationRepeater(animationState: Bool, autoreverses:Bool = true) -> Animation{
        if animationState{
            return Animation.easeOut(duration: 1).repeatForever(autoreverses: autoreverses);
        }
        else{
            return Animation.easeOut(duration: 1)
        }
    }
}


struct ContentView: View {
    @State private var statement:String = "Enter Statement";
    @State private var speechImageState:String = "mute";
    @State private var playState:Bool = false;
    @State private var animationState:Bool = false;
    @State private var buttonLabel: String = "Text to Talk";
    @State private var utterance: AVSpeechUtterance = AVSpeechUtterance();
    @State private var synthesizer: AVSpeechSynthesizer = AVSpeechSynthesizer();

    
    var body: some View {
        ZStack{
            Color("background")
                .ignoresSafeArea()
            VStack{
                //MARK: - Text Entry
                TextEditor(text: $statement)
                   .padding()
                   .background(Color.white)
                   .foregroundColor(Color.black)
                   .frame(width: UIScreen.main.bounds.width-80, height: UIScreen.main.bounds.height-500)
                   .cornerRadius(25)
                Spacer()
                
                //MARK: - Animation Image
                ZStack{
                    ZStack{
                        //outer circle
                        Circle()
                            .trim(from: 0.6, to:0.9)
                            .rotation(Angle(degrees:90))
                            .stroke(Color("accent"),lineWidth:10)
                            .frame(width: 250, height: 250, alignment: .center)
                            .opacity(animationState ?0.4:0)
                            .animation(Animation.default.animationRepeater(animationState: animationState, autoreverses: true))
                        Circle()
                            .trim(from: 0.6, to:0.9)
                            .rotation(Angle(degrees:270))
                            .stroke(Color("accent"),lineWidth:10)
                            .frame(width: 250, height: 250, alignment: .center)
                            .opacity(animationState ?0.4:0)
                            .animation(Animation.default.animationRepeater(animationState: animationState, autoreverses: true))
                        //middle circle
                        Circle()
                            .trim(from: 0.6, to:0.9)
                            .rotation(Angle(degrees:90))
                            .stroke(Color("accent"),lineWidth:10)
                            .frame(width: 200, height: 200, alignment: .center)
                            .opacity(animationState ?0.4:0)
                            .animation(Animation.default.animationRepeater(animationState: animationState, autoreverses: true))
                        Circle()
                            .trim(from: 0.6, to:0.9)
                            .rotation(Angle(degrees:270))
                            .stroke(Color("accent"),lineWidth:10)
                            .frame(width: 200, height: 200, alignment: .center)
                            .opacity(animationState ?0.4:0)
                            .animation(Animation.default.animationRepeater(animationState: animationState, autoreverses: true))
                        //inner circle
                        Circle()
                            .trim(from: 0.6, to:0.9)
                            .rotation(Angle(degrees:90))
                            .stroke(Color("accent"),lineWidth:10)
                            .frame(width: 150, height: 150, alignment: .center)
                            .opacity(animationState ?0.4:0)
                            .animation(Animation.default.animationRepeater(animationState: animationState, autoreverses: true))
                        Circle()
                            .trim(from: 0.6, to:0.9)
                            .rotation(Angle(degrees:270))
                            .stroke(Color("accent"),lineWidth:10)
                            .frame(width: 150, height: 150, alignment: .center)
                            .opacity(animationState ?0.4:0)
                            .animation(Animation.default.animationRepeater(animationState: animationState, autoreverses: true))
                    }
        

                    Image(speechImageState)
                        .resizable()
                        .frame(width: 100, height: 100, alignment: .center)
                }
                
           
                
                Spacer()
                Button(action:{
                    utterance = AVSpeechUtterance(string: statement)
                    utterance.voice = AVSpeechSynthesisVoice(language: "en-US")

                    utterance.rate = 0.5

                    
                    playState = !playState;
                    print(synthesizer.isSpeaking)
                    if(playState){
                        synthesizer.speak(utterance)

                        speechImageState = "microphone";
                        animationState = true;
                        buttonLabel = "Cancel";
                    }
                    else{
                        synthesizer.stopSpeaking(at: AVSpeechBoundary.immediate);

                        speechImageState = "mute";
                        animationState = false;
                        buttonLabel = "Text to Talk";
                    }
                    
                    
                   
                
                }){
                    Text(buttonLabel)
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
