import Foundation

// Feature: FlipBanner에 남은 시간을 countdown

// 문제점:
// 서버에서 남은 시간을 Milliseconds (Int)로 받음
// 안드는 시스템 시간 = milliseconds Long 타입 (iOS는 Date 타입)

// Timer로 1초씩 남은 시간을 빼주는 방법은
// background/foreground 전환 시 또는 화면 이탈/재진입 시 처리가 필요
// 안보이는 화면의 timer를 돌리는게 비효율적, timerPaused한 기간을 남은시간에 반영할 때 오차가 발생함

// 해결방법:
// 서버에서 받은 남은 시간으로 이벤트 종료시점 (Date 타입)을 계산
// 화면에서 벗어나면 timer invalidate 시킴
// 화면을 다시 띄울 때 Date를 통해 남은 시간을 정확히 계산하고, timer 재게

func calculateEndDate(fromMilliseconds remainingMilliseconds: Int) -> Date {
    // 현재 시간을 가져옴
    let currentDate = Date()
    
    // ms -> s
    let timeInterval = TimeInterval(remainingMilliseconds) / 1000.0
    
    // 이벤트 종료시간 = 현재 시간 + timeInterval
    let endDate = currentDate.addingTimeInterval(timeInterval)
    
    return endDate
}

print("Current date: \(Date().formatted(date: .long, time: .complete))")

let remainingMilliseconds1Min: Int = 60_000 // 60,000ms = 1분
let remainingMilliseconds1Day: Int = 86_400_000       // 1일
let remainingMilliseconds1Week: Int = 604_800_000      // 1주일
let remainingMilliseconds1Month: Int = 2_592_000_000   // 1개월 (30일 기준)
let remainingMilliseconds2Year: Int = 31_536_000_000 * 2   // 2년 (365일 기준)
let endDate1Min: Date = calculateEndDate(fromMilliseconds: remainingMilliseconds1Min)
let endDate1Day: Date = calculateEndDate(fromMilliseconds: remainingMilliseconds1Day)
let endDate1Week: Date = calculateEndDate(fromMilliseconds: remainingMilliseconds1Week)
let endDate1Month: Date = calculateEndDate(fromMilliseconds: remainingMilliseconds1Month)
let endDate2Year: Date = calculateEndDate(fromMilliseconds: remainingMilliseconds2Year)
print("endDate1Min: \(endDate1Min.formatted(date: .long, time: .complete))")
print("endDate1Day: \(endDate1Day.formatted(date: .long, time: .complete))")
print("endDate1Week: \(endDate1Week.formatted(date: .long, time: .complete))")
print("endDate1Month: \(endDate1Month.formatted(date: .long, time: .complete))")
print("endDate1Year: \(endDate2Year.formatted(date: .long, time: .complete))")

final class CommonDateFormatter {
    // MARK: - Nested Types
    enum DateStyle {
        case timeOnly, monthDay, monthDayYear // msg - roomList
        case weekMonthDayYear // msg - messageList
        
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
    static let shared = CommonDateFormatter()
    var currentDateText: String {
        return iso8601Formatter.string(from: Date())
    }
    
    private let calendar = Calendar.autoupdatingCurrent // 일본 달력은 gregorian 아님
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US") // 언어/지역 설정에 관계없이 항상 Apr 28 형태로 출력
        formatter.timeZone = .autoupdatingCurrent // 현재 사용자의 시스템 기본값 (위치 기반) 또는 수동 설정값이 적용됨
        return formatter
    }()
    private let iso8601Formatter: ISO8601DateFormatter = {
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
    
    func formattedByTimeInterval(from date: Date) -> String? {
        guard let timeInterval = caculateTimeIntervalSinceNow(from: date) else { return nil }
        
        dateFormatter.dateFormat = timeInterval.dateFormat
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
    
    func formattedRemainTime(to dateText: String) -> (Bool, String)? {
        guard let date1 = date(from: currentDateText),
              let date2 = date(from: dateText) else { return nil }
        
        let isExpired = calendar.compare(date1, to: date2, toGranularity: .second) == .orderedDescending
        let countdownComponents = calendar.dateComponents([.hour, .minute, .second], from: date1, to: date2)
        
        guard let hours = countdownComponents.hour,
              let minutes = countdownComponents.minute,
              let seconds = countdownComponents.second else { return nil }
        
        let remainTimeText = isExpired ? "00:00:00" : String(format: "%02d:%02d:%02d", hours, minutes, seconds)
        
        return (isExpired, remainTimeText)
    }
    
    private func date(from dateText: String) -> Date? {
        return iso8601Formatter.date(from: dateText)
    }
    
    private func caculateTimeIntervalSinceNow(from date: Date) -> TimeIntervalKind? {
        if calendar.isDateInToday(date) {
            return .inToday
        }
        
        let isYearPassed = calendar.compare(Date(), to: date, toGranularity: .year) == .orderedAscending // 현재보다 미래시점
        
        print("!!!", isYearPassed)
        return isYearPassed ? .yearPassed : .inThisYear
    }
    
    private func caculateTimeIntervalSinceNow(from dateText: String) -> TimeIntervalKind? {
        guard let date = date(from: dateText) else { return nil }
      
        if calendar.isDateInToday(date) {
            return .inToday
        }
        
        let isYearPassed = calendar.compare(Date(), to: date, toGranularity: .year) == .orderedDescending // 현재보다 과거시점
        
        return isYearPassed ? .yearPassed : .inThisYear
    }
}

let formattedDate1Min = CommonDateFormatter.shared.formattedByTimeInterval(from: endDate1Min)
let formattedDate1Day = CommonDateFormatter.shared.formattedByTimeInterval(from: endDate1Day)
let formattedDate1Week = CommonDateFormatter.shared.formattedByTimeInterval(from: endDate1Week)
let formattedDate1Month = CommonDateFormatter.shared.formattedByTimeInterval(from: endDate1Month)
let formattedDate2Year = CommonDateFormatter.shared.formattedByTimeInterval(from: endDate2Year)

print("FormattedDate1Min: \(formattedDate1Min)")
print("FormattedDate1Day: \(formattedDate1Day)")
print("FormattedDate1Week: \(formattedDate1Week)")
print("FormattedDate1Month: \(formattedDate1Month)")
print("FormattedDate2Year: \(formattedDate2Year)")

//FormattedDate1Min: Optional("PM 12:16")
//FormattedDate1Day: Optional("Aug 15")
//FormattedDate1Week: Optional("Aug 21")
//FormattedDate1Month: Optional("Sep 13")
//FormattedDate2Year: Optional("Aug 14, 2026")
