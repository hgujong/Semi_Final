//
//  CustomDatePicker.swift
//  studydatepicker
//
//  Created by 이채연 on 2023/01/03.
//

import SwiftUI

struct CustomDatePicker: View {
    @Binding var currentDate: Date
    @State private var AddTask = false
    @State var currentMonth: Int = 0
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack{
                    let days: [String] = ["S","M","T","W","T","F","S"]
                    
                    HStack{
                        HStack(alignment: .top){
                            Text(extraDate()[0])
                                .font(.system(size:15))
                            Text(extraDate()[1])
                                .font(.system(size:15))
                        }
                        Spacer()
                        Button{
                            withAnimation{
                                currentMonth -= 1
                            }
                        } label: {
                            Image(systemName: "chevron.left")
                                .font(.system(size:15))
                                .foregroundColor(.accentColor)
                        }
                        .frame(width: 20, height: 5)
                        
                        Button{
                            withAnimation{
                                currentMonth += 1
                            }
                        } label: {
                            Image(systemName: "chevron.right")
                                .font(.system(size:15))
                                .foregroundColor(.accentColor)
                        }
                        .frame(width: 20, height: 20)
                        NavigationLink(destination: TaskListView()) {
                            Image(systemName: "plus")
                                .font(.system(size:15))
                                .foregroundColor(.accentColor)
                        }
                        .frame(width: 20, height: 5)
                    }//HStack
                    .padding(.horizontal)
                    
                    HStack(spacing: 18){
                        ForEach(days,id:\.self){day in
                            Text(day)
                                .font(.system(size:15))
                                .fontWeight(.bold)
                        }
                    }
                    
                    let columns = Array(repeating: GridItem(.flexible()), count: 7)
                    
                    LazyVGrid(columns: columns){
                        ForEach(extractDate()){value in
                            CardView(value: value)
                                .background(
                                    Capsule()
                                        .fill(Color.accentColor)
                                        .padding(.horizontal,4)
                                        .opacity(isSameDay(date1: value.date, date2: currentDate) ? 1 : 0)
                                )
                                .onTapGesture {
                                    currentDate = value.date
                                }
                        }
                    }//LazyVGrid
                    
                    
                }//VStack
                .onChange(of: currentMonth){ newValue in
                    currentDate = getCurrentMonth()
                }
            }//ScrollView
        }//NavigationStack
    }
    
    @ViewBuilder
    func CardView(value: DateValue)->some View{
        VStack{
            if value.day != -1{
                Text("\(value.day)")
                    .font(.system(size:16))
                    .fontWeight(.bold)
                    .foregroundColor(isSameDay(date1: value.date, date2: currentDate) ? .white : .primary)
                    .frame(maxWidth: .infinity )
                
                
            }
        }
        .padding(.vertical,5)
        .frame(height: 20,alignment: .center)
    }
    
    func isSameDay(date1: Date,date2: Date)->Bool{
        let calendar = Calendar.current
        
        return calendar.isDate(date1, inSameDayAs: date2)
    }
    func extraDate()->[String]{
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY MMMM"
        
        let date = formatter.string(from: currentDate)
        return date.components(separatedBy: " ")
    }
    
    func getCurrentMonth()->Date{
        let calendar = Calendar.current
        guard let currentMonth = calendar.date(byAdding: .month, value: self.currentMonth, to: Date()) else{
            return Date()
        }
        return currentMonth
    }
    
    func extractDate()->[DateValue]{
        let calendar = Calendar.current
        
        let currentMonth = getCurrentMonth()
        
        var days = currentMonth.getAllDates().compactMap { date -> DateValue in
            
            let day = calendar.component(.day, from: date)
            
            return DateValue(day: day, date: date)
        }
        
        let firstWeekday = calendar.component(.weekday, from: days.first?.date ?? Date())
        
        for _ in 0..<firstWeekday - 1{
            days.insert(DateValue(day: -1, date: Date()), at: 0)
        }
        return days
    }
}

struct CustomDatePicker_Previews: PreviewProvider {
    static var previews: some View{
        Home()
        
    }
}
extension Date{
    func getAllDates()->[Date]{
        let calendar = Calendar.current
        let startDate = calendar.date(from: Calendar.current.dateComponents([.year,.month], from: self))!
        let range = calendar.range(of: .day, in: .month, for: startDate)!
        
        
        return range.compactMap {day->Date in
            return calendar.date(byAdding: .day, value: day - 1, to: startDate)!
        }
    }
}

