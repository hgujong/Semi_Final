//
//  DetailView.swift
//  watchCRUD Watch App
//
//  Created by 이채연 on 2023/02/02.
//

import SwiftUI

struct DetailView: View {
    //Property
    let task: Task
    let count: Int
    let index: Int
    //Body
    var body: some View {
        VStack(alignment: .center, spacing: 3){
            //Header
            HStack{
                Capsule()
                    .frame(height: 1)
                Image(systemName:"list.bullet.rectangle.fill")
                Capsule()
                    .frame(height: 1)
            }//HStack
            .foregroundColor(.accentColor)
            //Content
            Spacer()
            ScrollView(.vertical) {
                Text(task.text)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
            }//ScrollView
            Spacer()
            //Footer
            HStack(alignment: .center) {
                Image(systemName: "gear")
                    .imageScale(.large)
                Spacer()
                Text("\(count)/ \(index+1)")
                Spacer()
                Image(systemName: "info.circle")
                    .imageScale(.large)
                
            }//Hstack
            .foregroundColor(.secondary)
        }//VStack
        .padding(3)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var sampleData: Task = Task(id: UUID(), text: "Hello")
    static var previews: some View {
        
        DetailView(task: sampleData, count: 5, index: 1)
    }
}
