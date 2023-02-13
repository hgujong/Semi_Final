//
//  Home.swift
//  watchCRUD Watch App
//
//  Created by 이채연 on 2023/02/06.
//

import SwiftUI

struct Home: View {
    @State var currentDate: Date = Date()
    var body: some View {
        VStack{
            CustomDatePicker(currentDate: $currentDate)
            
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
