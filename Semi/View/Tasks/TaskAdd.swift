//
//  TaskAdd.swift
//  Semi
//
//  Created by 서종현 on 2023/01/16.
//

import SwiftUI

struct TaskAdd: View {
    @State private var title = ""
    @State private var note = ""
    @Binding var presentAddTaskSheet: Bool
    @Binding var isLoggedIn: Bool
    @Binding var model: ViewModel
    
    
    var body: some View {
        NavigationView{
            VStack {
                HStack {
                    Button {
                        presentAddTaskSheet = false
                    } label: {
                        Text("Cancel")
                            .padding([.top, .leading])
                    }
                    //.buttonStyle(.borderless)
                    
                    Spacer()
                    
                    Button {
                        model.addTodo(title: title, note: note, date: model.picked)
                        model.getTodoData(date: model.picked)
                        presentAddTaskSheet = false
                    } label: {
                        Text("Done")
                            .padding([.top, .trailing])
                    }
                }
                
                Text(model.picked)
                
                Form{
                    Section(header: Text("Title")) {
                        TextField("Title", text: $title, axis: .vertical)
                            .autocapitalization(.none)
                            .autocorrectionDisabled()
                    }
                    Section(header: Text("Note")) {
                        TextField("Note", text: $note, axis: .vertical)
                            .autocapitalization(.none)
                            .autocorrectionDisabled()
                    }
                }
            }
        }
        
    }
    
}

struct TaskAdd_Previews: PreviewProvider {
    static var previews: some View {
        TaskAdd(presentAddTaskSheet: .constant(false), isLoggedIn: .constant(false), model: .constant(.init()))
    }
}
