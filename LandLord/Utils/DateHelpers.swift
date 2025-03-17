//
//  DateHelpers.swift
//  LandLord
//
//  Created for bunkeboyLandLord2
//  Medieval 8-bit themed real estate app
//

import Foundation

/// Date utility functions for the LandLord app
struct DateHelpers {
    
    /// Calendar instance for date calculations
    static let calendar = Calendar.current
    
    /// Checks if a given date is today
    /// - Parameter date: The date to check
    /// - Returns: True if the date is today, false otherwise
    ///
    /// Example:
    /// ```
    /// let isToday = DateHelpers.isToday(date: someDate)
    /// // Returns true if someDate is today
    /// ```
    static func isToday(date: Date) -> Bool {
        return calendar.isDateInToday(date)
    }
    
    /// Gets the start of the current day
    /// - Returns: Date representing the start of today (midnight)
    ///
    /// Example:
    /// ```
    /// let todayStart = DateHelpers.startOfDay()
    /// // Returns 2023-05-15 00:00:00 if today is May 15, 2023
    /// ```
    static func startOfDay() -> Date {
        return calendar.startOfDay(for: Date())
    }
    
    /// Gets the start of the specified day
    /// - Parameter date: The date to get the start of day for
    /// - Returns: Date representing the start of the specified day (midnight)
    ///
    /// Example:
    /// ```
    /// let dayStart = DateHelpers.startOfDay(for: someDate)
    /// // Returns someDate with time set to 00:00:00
    /// ```
    static func startOfDay(for date: Date) -> Date {
        return calendar.startOfDay(for: date)
    }
    
    /// Calculates the number of days between two dates
    /// - Parameters:
    ///   - start: The start date
    ///   - end: The end date
    /// - Returns: Number of days between the dates
    ///
    /// Example:
    /// ```
    /// let days = DateHelpers.daysBetween(start: lastLogin, end: Date())
    /// // Returns 3 if lastLogin was 3 days ago
    /// ```
    static func daysBetween(start: Date, end: Date) -> Int {
        let startDay = calendar.startOfDay(for: start)
        let endDay = calendar.startOfDay(for: end)
        
        let components = calendar.dateComponents([.day], from: startDay, to: endDay)
        return components.day ?? 0
    }
    
    /// Formats a date according to the specified style
    /// - Parameters:
    ///   - date: The date to format
    ///   - style: The date style to use (default: .medium)
    /// - Returns: Formatted date string
    ///
    /// Example:
    /// ```
    /// let formatted = DateHelpers.formatDate(date: Date())
    /// // Returns "May 15, 2023" if today is May 15, 2023
    /// ```
    static func formatDate(date: Date, style: DateFormatter.Style = .medium) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = style
        formatter.timeStyle = .none
        return formatter.string(from: date)
    }
    
    /// Formats a date with a medieval style
    /// - Parameter date: The date to format
    /// - Returns: Medieval-styled date string
    ///
    /// Example:
    /// ```
    /// let medieval = DateHelpers.medievalDateFormat(date: Date())
    /// // Returns "The 15th Day of May, Year of Our Lord 2023"
    /// ```
    static func medievalDateFormat(date: Date) -> String {
        let day = calendar.component(.day, from: date)
        let month = calendar.component(.month, from: date)
        let year = calendar.component(.year, from: date)
        
        let daySuffix: String
        switch day {
        case 1, 21, 31: daySuffix = "st"
        case 2, 22: daySuffix = "nd"
        case 3, 23: daySuffix = "rd"
        default: daySuffix = "th"
        }
        
        let monthNames = ["January", "February", "March", "April", "May", "June", 
                          "July", "August", "September", "October", "November", "December"]
        
        return "The \(day)\(daySuffix) Day of \(monthNames[month-1]), Year of Our Lord \(year)"
    }
    
    /// Checks if it's a new day since the app was last opened
    /// - Parameter lastOpened: The date when the app was last opened
    /// - Returns: True if it's a new day, false otherwise
    ///
    /// Example:
    /// ```
    /// let isNewDay = DateHelpers.isNewDay(lastOpened: lastOpenedDate)
    /// // Returns true if lastOpenedDate was yesterday or earlier
    /// ```
    static func isNewDay(lastOpened: Date) -> Bool {
        let lastOpenedDay = calendar.startOfDay(for: lastOpened)
        let today = calendar.startOfDay(for: Date())
        return lastOpenedDay < today
    }
    
    /// Returns yesterday's date
    /// - Returns: Date representing yesterday
    ///
    /// Example:
    /// ```
    /// let yesterday = DateHelpers.yesterday()
    /// // Returns 2023-05-14 if today is May 15, 2023
    /// ```
    static func yesterday() -> Date {
        return calendar.date(byAdding: .day, value: -1, to: Date()) ?? Date()
    }
    
    /// Returns tomorrow's date
    /// - Returns: Date representing tomorrow
    ///
    /// Example:
    /// ```
    /// let tomorrow = DateHelpers.tomorrow()
    /// // Returns 2023-05-16 if today is May 15, 2023
    /// ```
    static func tomorrow() -> Date {
        return calendar.date(byAdding: .day, value: 1, to: Date()) ?? Date()
    }
    
    /// Checks if a date is within the last week
    /// - Parameter date: The date to check
    /// - Returns: True if the date is within the last 7 days
    ///
    /// Example:
    /// ```
    /// let isRecent = DateHelpers.isWithinLastWeek(date: someDate)
    /// // Returns true if someDate is within the last 7 days
    /// ```
    static func isWithinLastWeek(date: Date) -> Bool {
        let daysAgo = daysBetween(start: date, end: Date())
        return daysAgo < 7 && daysAgo >= 0
    }
}

// MARK: - Date Extension

extension Date {
    /// Checks if this date is today
    var isToday: Bool {
        return DateHelpers.isToday(date: self)
    }
    
    /// Returns the start of this day
    var startOfDay: Date {
        return DateHelpers.startOfDay(for: self)
    }
    
    /// Calculates days between this date and another date
    /// - Parameter date: The other date
    /// - Returns: Number of days between dates
    func daysBetween(and date: Date) -> Int {
        return DateHelpers.daysBetween(start: self, end: date)
    }
    
    /// Formats this date with the specified style
    /// - Parameter style: The date style to use
    /// - Returns: Formatted date string
    func formatted(style: DateFormatter.Style = .medium) -> String {
        return DateHelpers.formatDate(date: self, style: style)
    }
    
    /// Formats this date in medieval style
    var medievalFormat: String {
        return DateHelpers.medievalDateFormat(date: self)
    }
    
    /// Checks if this date represents a new day compared to now
    var isNewDay: Bool {
        return DateHelpers.isNewDay(lastOpened: self)
    }
    
    /// Checks if this date is within the last week
    var isWithinLastWeek: Bool {
        return DateHelpers.isWithinLastWeek(date: self)
    }
    
    /// Returns a date representing yesterday relative to this date
    var yesterday: Date {
        return DateHelpers.calendar.date(byAdding: .day, value: -1, to: self) ?? self
    }
    
    /// Returns a date representing tomorrow relative to this date
    var tomorrow: Date {
        return DateHelpers.calendar.date(byAdding: .day, value: 1, to: self) ?? self
    }
}

// MARK: - Usage Examples

/*
 // Check if a date is today
 let isToday = Date().isToday
 // or
 let isToday = DateHelpers.isToday(date: Date())
 
 // Get start of current day
 let dayStart = DateHelpers.startOfDay()
 
 // Calculate days between dates
 let streak = DateHelpers.daysBetween(start: userLastActive, end: Date())
 // or
 let streak = userLastActive.daysBetween(and: Date())
 
 // Format a date
 let formatted = DateHelpers.formatDate(date: Date())
 // or
 let formatted = Date().formatted()
 
 // Medieval date format
 let medieval = Date().medievalFormat
 // Returns something like "The 15th Day of May, Year of Our Lord 2023"
 
 // Check if it's a new day since last app open
 let isNewDay = DateHelpers.isNewDay(lastOpened: lastOpenTime)
 // or
 let isNewDay = lastOpenTime.isNewDay
 */ 