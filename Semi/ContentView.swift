//
//  ContentView.swift
//  Semi
//
//  Created by 서종현 on 2023/01/12.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestore

struct ContentView: View {
    @State var model = ViewModel()
    @State var isLoggedIn = false
    
    var body: some View {
        if isLoggedIn {
            Main(model: $model, isLoggedIn: $isLoggedIn)
        }
        else {
            Login(model: $model, isLoggedIn: $isLoggedIn)
        }
    }
    
    init(){
        model.getTodoData(date: model.picked)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
