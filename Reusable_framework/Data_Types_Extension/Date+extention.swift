//
//  Date+extention.swift
//  ARCHECO-LightCafe
//
//  Created by Ahsanul Kabir on 6/11/20.
//  Copyright © 2020 Archeco. All rights reserved.
//

import Foundation

extension Date {
    
    static var today: Date {
        let now = Date()
        let calender = Calendar.current
        let today = calender.startOfDay(for: now)
        
        return today
    }

    //  ----------------------------------------------------------------------
    public var isToDay: Bool {
        let nowDateStr: String = Date().dateString("yyyy-MM-dd")
        let dateStr: String = self.dateString("yyyy-MM-dd")
        
        return (nowDateStr == dateStr)
    }
    
    //  ----------------------------------------------------------------------
    public var startOfDay: Date {
        let calender = Calendar.current
        let today = calender.startOfDay(for: self)
        return today
    }
    
    //  ----------------------------------------------------------------------
    public func dateString(_ format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        return dateFormatter.string(from: self)
    }
    
    //  ----------------------------------------------------------------------
    public func systemlocalDateString(_ format: String) -> String {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = NSLocale.system
        
        return formatter.string(from: self)
    }

    var weekdayName: String {
        let formatter = DateFormatter(); formatter.dateFormat = "E"
        return formatter.string(from: self as Date)
    }

    func dayNumberOfWeek() -> Int? {
        return Calendar.current.dateComponents([.weekday], from: self).weekday
    }
    
    var year: Int? {
        let calendar = Calendar.current
        let currentComponents = calendar.dateComponents([.year], from: self)
        return currentComponents.year
    }
    static var yesterday: Date { return Date().dayBefore }
    static var tomorrow:  Date { return Date().dayAfter }
    var dayBefore: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: noon)!
    }
    var dayAfter: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: noon)!
    }
    var noon: Date {
        return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }
    var month: Int {
        return Calendar.current.component(.month,  from: self)
    }
    var isLastDayOfMonth: Bool {
        return dayAfter.month != month
    }

    var previousWeek:Date{
        return Calendar.current.date(byAdding: .day, value: -7, to: noon)!
    }
    
    var nextWeek:Date{
        return Calendar.current.date(byAdding: .day, value: 7, to: noon)!
    }
    
    var previousMonth:Date{
        return Calendar.current.date(byAdding: .month, value: -1, to: noon)!
    }
    
    var nextMonth:Date{
        return Calendar.current.date(byAdding: .month, value: +1, to: noon)!
    }

    var previousYear:Date{
        return Calendar.current.date(byAdding: .year, value: -1, to: noon)!
    }
    
    var nextYear:Date{
        return Calendar.current.date(byAdding: .year, value: +1, to: noon)!
    }

    var numberOfDaysInMonth:Int {
        let calendar = Calendar.current
        let interval = calendar.dateInterval(of: .year, for: self)!
        // Compute difference in days:
        let days = calendar.dateComponents([.day], from: interval.start, to: interval.end).day!
        return days
    }
    
    var begainOfDay: Date {
        var components = DateComponents()
        components.day = 1
        components.hour = 0
        components.minute = 0
        components.second = 1
        return Calendar.current.date(byAdding: components, to: startOfDay)!
    }

    var endOfDay: Date {
        let calendar = Calendar.current
        return calendar.date(bySettingHour: 23, minute: 59, second: 59, of: self)!
    }

    var startOfMonth: Date {
        let components = Calendar.current.dateComponents([.year, .month], from: startOfDay)
        return Calendar.current.date(from: components)!
    }

    var endOfMonth: Date {
        var components = DateComponents()
        components.month = 1
        components.second = -1
        return Calendar.current.date(byAdding: components, to: startOfMonth)!
    }

    var dateStartAtzero:Date{
        let gregorian = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!

        var components = gregorian.components([.year, .month, .day, .hour, .minute, .second], from: self)
        components.hour = 0
        components.minute = 0
        components.second = 1
        return gregorian.date(from: components)!
    }
    

    /// Convert `Timestamp` to `Date` .
    ///
    /// - parameter millis:`Timestamp` value in type `UInt64`.
    
    init(millis: UInt64) {
        self = Date(timeIntervalSince1970: TimeInterval(millis / 1000))
        self.addTimeInterval(TimeInterval(Double(millis % 1000) / 1000 ))
    }
    
    init(seconds: UInt64?) {
        let _seconds = seconds ?? 1000000000
        let millis = _seconds * 1000
        self = Date(timeIntervalSince1970: TimeInterval(millis / 1000))
        self.addTimeInterval(TimeInterval(Double(millis % 1000) / 1000 ))
    }
    
    func toString(format: String) -> String {
        let df = DateFormatter()
        df.dateFormat = format
        return df.string(from: self)
    }

}
