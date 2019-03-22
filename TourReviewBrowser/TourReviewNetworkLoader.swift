import Siesta

struct TourReviewNetworkLoader {
    
    fileprivate static let apiBaseURL
        = ConfigurationReader.value(forKey: .apiBaseURL)
    
    let service = Service(baseURL: TourReviewNetworkLoader.apiBaseURL)
    
    
}
