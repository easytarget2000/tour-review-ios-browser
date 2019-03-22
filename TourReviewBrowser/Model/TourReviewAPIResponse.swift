struct TourReviewAPIResponse: Codable {
    
    let success: Bool
    
    enum CodingKeys: String, CodingKey {
        case success = "status"
    }
}
