import Foundation

struct ConfigurationReader {
    
    enum Key: String {
        case tourReviewAPIBaseURL = "TourReviewAPIBaseURL"
    }
    
    static func value(forKey key: Key) -> String {
        let value = Bundle.main.infoDictionary![key.rawValue] as! String
        return value.replacingOccurrences(of: "\\", with: "")
    }
    
}
