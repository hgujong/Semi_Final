//
//  Calendar.swift
//  Semi
//
//  Created by 서종현 on 2023/01/12.
//

import SwiftUI

struct Calendar: View {
    @Binding var model: ViewModel
    @Binding var isLoggedIn: Bool
    
    var picked: String {
        dateToString(date: model.date, format: "YYYY MM dd")
    }
    
    var body: some View {
        VStack {
            DatePicker(
                "DatePicker",
                selection: $model.date,
                displayedComponents: .date
            )
            .datePickerStyle(.graphical)
            .labelsHidden()
            .accentColor(.blue)
            
            //Text("Date is \(picked)")
        }
    }
    
    func dateToString(date: Date, format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        
        return dateFormatter.string(from: date)
    }
    
}

struct Calendar_Previews: PreviewProvider {
    static var previews: some View {
        Calendar(model: .constant(.init()), isLoggedIn: .constant(false))
    }
}
