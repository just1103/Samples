import Foundation

final class DateFormatManager {
    
    // MARK: - Nested Types
    enum DateStyle {
        case timeOnly, monthDay, monthDayYear
        case weekMonthDayYear
        
        var dateFormat: String {
            switch self {
            case .timeOnly:
                return "a h:mm" // AM 3:04
            case .monthDay:
                return "MMM d" // Apr 28
            case .monthDayYear:
                return "MMM d, yyyy" // Apr 28, 2023
            case .weekMonthDayYear:
                return "EEEE, MMM d, yyyy" // Friday, Apr 28, 2023
            }
        }
    }
    
    private enum TimeIntervalKind {
        case inToday, inThisYear, yearPassed
        
        var dateFormat: String {
            switch self {
            case .inToday: // 수신 당일 (오늘 기준 0시 이상)
                return DateStyle.timeOnly.dateFormat
            case .inThisYear: // 당일이 지난 경우 (올해 기준 1/1 0시 이상)
                return DateStyle.monthDay.dateFormat
            case .yearPassed: // 당해가 지난 경우
                return DateStyle.monthDayYear.dateFormat
            }
        }
    }
    
    // MARK: - Properties
    static let shared = DateFormatManager()
    
    var currentDateText: String {
        return iso8601Formatter.string(from: Date())
    }
    
    private let calendar = Calendar.autoupdatingCurrent
    
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US") // 언어/지역 설정에 관계없이 항상 Apr 28 형태로 출력
        formatter.timeZone = .autoupdatingCurrent // 현재 사용자의 시스템 기본값 (위치 기반) 또는 수동 설정값이 적용됨
        return formatter
    }()
    
    private(set) var iso8601Formatter: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        // "yyyy-MM-dd'T'HH:mm:ssZZZZZ" (ex. 2023-04-27T05:29:07+00:00)
        formatter.formatOptions = [.withInternetDateTime]
        return formatter
    }()
    
    // MARK: - Initializers
    private init() {}
    
    // MARK: - Methods
    func isSameDay(_ dateText1: String, _ dateText2: String) -> Bool? {
        guard let date1 = date(from: dateText1),
              let date2 = date(from: dateText2) else { return nil }
        
        return calendar.compare(date1, to: date2, toGranularity: .day) == .orderedSame
    }
    
    func isTimeGapGreaterThanTenMinutes(_ dateText1: String, _ dateText2: String) -> Bool? {
        guard let date1 = date(from: dateText1),
              let date2 = date(from: dateText2) else { return nil }
        
        let timeDifference = abs(date1.timeIntervalSince(date2))
        
        return timeDifference > 600
    }
    
    func formattedByDateStyle(_ dateStyle: DateStyle, from dateText: String) -> String? {
        guard let date = date(from: dateText) else { return nil }
        
        dateFormatter.dateFormat = dateStyle.dateFormat
        let formattedString = dateFormatter.string(from: date)
        
        return formattedString
    }
    
    func formattedByTimeInterval(from dateText: String) -> String? {
        guard let date = date(from: dateText),
              let timeInterval = caculateTimeIntervalSinceNow(from: dateText) else { return nil }
        
        dateFormatter.dateFormat = timeInterval.dateFormat
        let formattedString = dateFormatter.string(from: date)
        
        return formattedString
    }
    
    func date(from dateText: String) -> Date? {
        return iso8601Formatter.date(from: dateText)
    }
    
    private func caculateTimeIntervalSinceNow(from dateText: String) -> TimeIntervalKind? {
        guard let date = date(from: dateText) else { return nil }
      
        if calendar.isDateInToday(date) {
            return .inToday
        }
        
        let isYearPassed = calendar.compare(Date(), to: date, toGranularity: .year) == .orderedDescending
        
        return isYearPassed ? .yearPassed : .inThisYear
    }
    
    // Global
    func formattedRemainTime(to dateText: String, compareIncludingDays: Bool = false) -> (Bool, String)? {
        guard let currentDate = date(from: currentDateText),
              let date = date(from: dateText) else { return nil }
        
        let isExpired = calendar.compare(currentDate, to: date, toGranularity: .second) == .orderedDescending
        
        let components: Set<Calendar.Component> = compareIncludingDays ? [.day, .hour, .minute, .second] : [.hour, .minute, .second]

        let countdownComponents = calendar.dateComponents(components, from: currentDate, to: date)
        
        guard let hours = countdownComponents.hour,
              let minutes = countdownComponents.minute,
              let seconds = countdownComponents.second else { return nil }
        
        // day 컴포넌트를 포함하지 않는 경우 0일로 기본 설정
        // 이게 없으면 터무니없이 큰 값이 반환됨
         let days = compareIncludingDays ? (countdownComponents.day ?? 0) : 0
         
        let remainTimeText = isExpired ? "00:00:00" : String(format: "%02d / %02d:%02d:%02d", days, hours, minutes, seconds)
        
        return (isExpired, remainTimeText)
    }
    
    // KR
    func formattedRemainTimeV2(to date: Date, isShort: Bool = false) -> String? {
        let currentDate = Date()
        let countdownComponents = calendar.dateComponents([.day, .hour, .minute, .second], from: currentDate, to: date)
        
        guard let days = countdownComponents.day,
              let hours = countdownComponents.hour,
              let minutes = countdownComponents.minute,
              let seconds = countdownComponents.second else { return nil }

        if isShort {
            // 72시간 초과 : 전체 시간 생략
            // 72시간 이하 : n일
            // 24시간 이하 : 23:14:59
            // expired시 : 00:00:00
            return if days > 3 {
                ""
            } else if days > 0 {
                "\(days)일"
            } else {
                "\(hours):\(minutes):\(seconds)" // or String(format: "%02d:%02d:%02d", hours, minutes, seconds)
            }
        } else {
            // 2일 (23시간 생략)
            // 23시간 3분 3초 (0일 생략)
            // 3분 3초 (0시간 생략)
            // 3초 (0분 생략)
            return if days > 0 {
                "\(days)일"
            } else if hours > 0 {
                "\(hours)시간 \(minutes)분 \(seconds)초"
            } else if minutes > 0 {
                "\(minutes)분 \(seconds)초"
            } else if seconds > 0 {
                "\(seconds)초"
            } else {
                nil
            }
        }
    }
    
}
