//
//  Timer.swift
//  watchCRUD Watch App
//
//  Created by 이채연 on 2023/02/07.
//

import SwiftUI

struct SwipeTabView: View {
    
    var body: some View {
        TabView() {
            VStack{
                Home()
                
            }
            VStack{
               TaskListView()
            }
        }
        .tabViewStyle(.page)
    }
}

struct SwipeTabView_Previews: PreviewProvider {
    static var previews: some View {
        SwipeTabView()
    }
}
