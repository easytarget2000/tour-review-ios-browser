struct TourReviewAPIResponse: Codable {
    
    enum CodingKeys: String, CodingKey {
        case success            = "status"
        case totalNumOfComments = "total_reviews_comments"
        case reviews            = "data"
    }
    
    let success: Bool
    
    let totalNumOfComments: Int
    
    let reviews: [TourReview]
    
}
