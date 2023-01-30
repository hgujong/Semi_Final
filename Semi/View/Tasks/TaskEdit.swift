//
//  TaskEdit.swift
//  Semi
//
//  Created by 서종현 on 2023/01/16.
//

import SwiftUI

struct TaskEdit: View {
    var body: some View {
            Form {
                Section(header: Text("Task")) {
                    Text("task")
                }
                Section(header: Text("Time")) {
                    Text("time")
                }
            }
            .navigationTitle("Todo")
    }
}

struct TaskEdit_Previews: PreviewProvider {
    static var previews: some View {
        TaskEdit()
    }
}
