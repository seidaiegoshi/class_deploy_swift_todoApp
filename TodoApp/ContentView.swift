//
//  ContentView.swift
//  TodoApp
//
//  Created by 江越正大 on 2023/02/07.
//

import SwiftUI

struct ContentView: View {
    @State var currentTodos: [Todo] = []
    @State var input = ""
    @AppStorage("todos") var todosData: Data  = Data()
    
    var body: some View {
        VStack (spacing:0){
            HStack{
                TextField("Todo",text:$input)
                    .padding()
                    .background(.white)
                    .cornerRadius(5)
                
                Button("Enter"){
                    do{
                        try
                        saveTodo(value: input)
                        input = ""
                    }
                    catch{
                        print(error.localizedDescription)
                    }
                }
                .buttonStyle(.bordered)
                .background(.blue)
                .foregroundColor(.white)
                .cornerRadius(5)
            }
            .padding()
            .background(.yellow)
            List(currentTodos,id:\.id){
                todo in Text(todo.value)
            }
        }
        .onAppear{
            do{
                try currentTodos = fetchTodos()
            }
            catch{
                print(error.localizedDescription)
            }
            
        }
        
    }
    
    
    func saveTodo(value:String) throws{
        let todo = Todo(id: UUID(), value: value)
        currentTodos.append(todo)
        
        let encodedTodos = try JSONEncoder().encode(currentTodos)
        todosData = encodedTodos
    }
    
    func fetchTodos() throws-> [Todo]{
        try JSONDecoder().decode([Todo].self,from:todosData)
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
