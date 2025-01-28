import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // 특정 이벤트 종료 시각 (미래 시점)
        let dateTexts: [String] = [
            "2024-11-05T23:15:06+09:00",
            "2024-11-05T17:15:06+09:00",
            "2024-11-05T01:15:06+09:00",
            
            "2024-11-04T23:15:06+09:00",
            "2024-11-04T17:15:06+09:00",
            "2024-11-04T01:15:06+09:00",
            
            "2024-11-03T23:15:06+09:00",
            "2024-11-03T17:15:06+09:00",
            "2024-11-03T01:15:06+09:00",
            
            "2024-11-02T23:15:06+09:00",
            "2024-11-02T17:15:06+09:00",
            "2024-11-02T01:15:06+09:00",
            
            "2024-11-01T23:15:06+09:00",
            "2024-11-01T18:15:06+09:00",
            "2024-11-01T12:15:06+09:00",
        ]
        
        let manager = DateFormatManager.shared
        
        print("compareIncludingDays false -----------")
        _ = dateTexts
            .compactMap { manager.formattedRemainTime(to: $0) }
            .map { print($0) }
        
        
        print("compareIncludingDays true -----------")
        // 비교 대상에서 days가 날아가고, 나머지 시간만 남음
        _ = dateTexts
            .compactMap { manager.formattedRemainTime(to: $0, compareIncludingDays: true) }
            .map { print($0) }
        
        
        print("shortFormat true -----------")
        _ = dateTexts
            .compactMap { manager.date(from: $0) }
//            .compactMap { manager.iso8601Formatter.date(from: $0) } // ???: 이건 왜 안되지
            .compactMap { manager.formattedRemainTimeV2(to: $0, isShort: true) }
    }

}
