import Foundation


private let dateTimePhotoFormatter = ISO8601DateFormatter()

extension Date {
    static func dateFromString(_ date: String) -> Date? {
        dateTimePhotoFormatter.date(from: date)
    }
}
