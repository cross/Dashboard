//
//  MyCalendar.swift
//  Dashboard
//
//  Created by Chris Ross on 4/8/23.
//

import SwiftUI

extension Calendar {
    func generateDates(
        inside interval: DateInterval,
        matching components: DateComponents
    ) -> [Date] {
        var dates: [Date] = []
        dates.append(interval.start)

        enumerateDates(
            startingAfter: interval.start,
            matching: components,
            matchingPolicy: .nextTime
        ) { date, _, stop in
            if let date = date {
                if date < interval.end {
                    dates.append(date)
                } else {
                    stop = true
                }
            }
        }

        return dates
    }
}

struct DayCell: View {
    @State var date: Date
    @State var hide: Bool = false
    static let cellSize: CGFloat = 35
//    var private cellTextColor: Color = nil
    
    var body: some View {
        if hide {
            //            cellTextColor = Color(.gray, alpha:0.5)
            Text("")
                .font(.system(size:7))
                .frame(width: DayCell.cellSize, height: DayCell.cellSize)
                .border(Color.gray.opacity(0.2))
                .padding(2)
        } else {
            Text(date, style:.date)
                .font(.system(size:7))
                .frame(width: DayCell.cellSize, height: DayCell.cellSize)
                .border(.purple, width:1.5)
                .padding(2)
        }
    }
}
struct MyCalendar: View {
    //let content: (Date) -> DayCell

    @Environment(\.sizeCategory) private var contentSize
    @Environment(\.calendar) private var calendar

    @State var selectedDate: Date = Date()
    @State private var month: Date = Date()
    @State private var days: [Date] = []

    private var columns: [GridItem] {
        let spacing: CGFloat = contentSize.isAccessibilityCategory ? 2 : 8
        return Array(repeating: GridItem(.flexible(minimum:DayCell.cellSize), spacing: spacing), count: 7)
    }
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 0) {
            ForEach(days, id: \.self) { date in
                if calendar.isDate(date, equalTo: month, toGranularity: .month) {
                    DayCell(date: date)
//                    var _ = print("date \(date) is in month \(month)")
                } else {
//                    var _ = print("date \(date) is outside of month \(month)")
                    DayCell(date: date, hide:true)
                }
            }
            /*
             DatePicker("Calendar", selection:$selectedDate, displayedComponents: [.date])
             .datePickerStyle(.graphical)
             .scaledToFit()
             */
        }//.frame(width: 600)
        .onAppear {
            // We're only going to be dealing with the current month for now
            month = Date()

            guard let monthInterval = calendar.dateInterval(of: .month, for: month),
                  let monthFirstWeek = calendar.dateInterval(of: .weekOfMonth, for: monthInterval.start),
                  let monthLastWeek = calendar.dateInterval(of: .weekOfMonth, for: monthInterval.end)
            else { return }
            /*
            print("monthInterval is \(monthInterval)")
            print("monthFirstWeek is \(monthFirstWeek)")
            print("monthLastWeek is \(monthLastWeek)")
             */
            days = calendar.generateDates(
                inside: DateInterval(start: monthFirstWeek.start, end: monthLastWeek.end),
                matching: DateComponents(hour: 0, minute: 0, second: 0)
            )
            print("days is \(days)")

        }
    }
}

struct MyCalendar_Previews: PreviewProvider {
    static var previews: some View {
        MyCalendar()
            .previewLayout(.fixed(width: 400.0, height: 300.0))
    }
}
