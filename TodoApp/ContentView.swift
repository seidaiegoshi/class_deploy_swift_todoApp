//
//  ContentView.swift
//  TodoApp
//
//  Created by 江越正大 on 2023/02/07.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("memo") var savedMemo = "default memo"
    @State var currentMemo = ""
    let seasons = ["spring", "summer", "fall", "winter"]
    var body: some View {
        VStack {
            HStack{
                TextField("Memo",text:$currentMemo)
                    .padding()
                    .background(.white)
                    .cornerRadius(5)
                
                Button("Enter"){
                    savedMemo = currentMemo
                    currentMemo = ""
                }
                .buttonStyle(.bordered)
                .background(.blue)
                .foregroundColor(.white)
                .cornerRadius(5)
                
            }
            .padding()
            .background(.yellow)
            List(seasons,id:\.self){
                season in Text(season)
            }
            
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
