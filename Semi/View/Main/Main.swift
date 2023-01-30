//
//  Main.swift
//  Semi
//
//  Created by 서종현 on 2023/01/12.
//

import SwiftUI

struct Main: View {
    @Binding var model: ViewModel
    @Binding var isLoggedIn: Bool
    @State private var selection: Tab = .home
    
    enum Tab {
        case home
        case friend
    }
    
    var body: some View {
        TabView(selection: $selection) {
            MainHome(model: $model, isLoggedIn: $isLoggedIn)
                .tabItem {
                    Label("Home", systemImage: "house")
                }
                .tag(Tab.home)
            FriendHome()
                .tabItem {
                    Label("Friend", systemImage: "person")
                }
                .tag(Tab.friend)
        }
        .accentColor(.blue)
    }
}

struct Main_Previews: PreviewProvider {
    static var previews: some View {
        Main(model: .constant(.init()), isLoggedIn: .constant(false))
    }
}
