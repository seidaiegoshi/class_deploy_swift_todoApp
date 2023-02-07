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
                    guard !input.isEmpty else{ return}
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
            List{
                ForEach(currentTodos) { todo in // ForEachで配列の要素を回す
                    Text(todo.value)
                }
                .onDelete { indexSet in // 該当のデータのindexSetが使える。indexSetという名前にしている
                    do{
                       try removeRows(at:indexSet)
                    }catch{
                        print(error.localizedDescription)
                    }
                        // スワイプして削除する際に保存されているデータからも削除する
                    }
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
    private func removeRows(at offsets: IndexSet) throws { // IndexSet型のデータを受け取る
        currentTodos.remove(atOffsets: offsets) // 配列から指定されたインデックスのデータを削除
        todosData = try JSONEncoder().encode(currentTodos) // 任意の要素が削除されたcollectTodosをEncodeして保存
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
