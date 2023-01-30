//
//  MainHome.swift
//  Semi
//
//  Created by 서종현 on 2023/01/12.
//  

import SwiftUI
import Firebase

struct MainHome: View {
    @Binding var model: ViewModel
    @Binding var isLoggedIn: Bool
    @State private var showingProfile = false
    @State private var showTask = false
    
    var body: some View {
        
        NavigationView {
            
            List {
                Calendar(model: $model, isLoggedIn: $isLoggedIn)
                
                Button {
                    model.getTodoData(date: model.picked)
                    showTask.toggle()
                } label: {
                    HStack {
                        Text("THINGS TO DO")
                            .bold()
                        
                        Spacer()
                        
                        Image(systemName: "chevron.compact.right")
                    }
                    .sheet(isPresented: $showTask) {
                        TaskList(isLoggedIn: $isLoggedIn, model: $model)
                    }
                }
            }
            .listStyle(.inset)
            .navigationTitle("TODOY")
            .toolbar {
                Button {
                    showingProfile.toggle()
                } label: {
                    Label("User Profile", systemImage: "person.crop.circle")
                }
            }
            .sheet(isPresented: $showingProfile) {
                ProfileSummary(model: $model, isLoggedIn: $isLoggedIn, image: Image("ProfilePic"))
            }
        }
    }
}

struct MainHome_Previews: PreviewProvider {
    static var previews: some View {
        MainHome(model: .constant(.init()), isLoggedIn: .constant(false))
    }
}
