//
//  ContentView.swift
//  watchCRUD Watch App
//
//  Created by 이채연 on 2023/02/02.
//

import SwiftUI


struct TaskListView: View {
    //Property
    @State private var tasks: [Task] = [Task]()
    @State private var text: String = ""
    @State private var pickDate = false
    
    //Function
    func getDocumentDirectory() ->URL {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return path[0]
    }
    
    func save(){
        //dump(tasks)
        do{
            let data = try JSONEncoder().encode(tasks)
            let url = getDocumentDirectory().appendingPathComponent("tasks")
            try data.write(to: url)
        } catch {
            print("Saving data has failed")
        }
    }
    
    func load(){
        DispatchQueue.main.async {
            do{
                let url = getDocumentDirectory().appendingPathComponent("tasks")
                let data = try Data(contentsOf: url)
                tasks = try JSONDecoder().decode([Task].self, from: data)
            } catch{
                //Do nothing
            }
        }
    }
    
    func delete(offsets: IndexSet){
        withAnimation{
            tasks.remove(atOffsets: offsets)
            save()
        }
    }
    
    //Body
    var body: some View {
        NavigationStack{
            VStack {
                HStack(alignment: .center, spacing: 4.0){
                    TextField("Add New Task",text: $text)
                    Button {
                        guard text.isEmpty == false else{ return}
                        let task = Task(id: UUID(), text: text)
                        tasks.append(task)
                        text = ""
                        save()
                    } label: {
                        Image(systemName:"plus")
                            .font(.system(size: 25, weight: .semibold))
                                                }
                    .fixedSize()
                    .buttonStyle(PlainButtonStyle())
                    .foregroundColor(.accentColor)
                    
                }//HStack
                
                Spacer()
                if tasks.count >= 1 {
                    List{
                        ForEach(0..<tasks.count, id: \.self){ i in
                            NavigationLink(destination: DetailView(task: tasks[i], count: tasks.count, index: i)) {
                                HStack{
                                    Capsule()
                                        .frame(width: 4)
                                        .foregroundColor(.accentColor)
                                    Text(tasks[i].text)
                                        .lineLimit(1)
                                        .padding(.leading, 5)
                                }//HStack
                            }//NavigationLink
                            
                        }//Loop
                        .onDelete(perform: delete)
                    }//List
                } else {
                    Spacer()
                    Image(systemName:"calendar.badge.plus")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.gray)
                        .opacity(0.25)
                        .padding(15)
                    Spacer()
                    
                }//else
                Spacer()
                
            }//VStack
            .navigationTitle("Tasks")
            .font(.system(size: 15))
            .onAppear(perform: {
                load()
            })
        }//NavigationStack
    }
}

struct TaskListView_Previews: PreviewProvider {
    static var previews: some View {
        TaskListView()
    }
}
