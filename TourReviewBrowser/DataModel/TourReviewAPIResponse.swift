struct TourReviewAPIResponse: Codable {
    
    enum CodingKeys: String, CodingKey {
        case success            = "status"
        case totalNumOfReviews  = "total_reviews_comments"
        case reviews            = "data"
    }
    
    let success: Bool
    
    let totalNumOfReviews: Int
    
    let reviews: [TourReview]
    
}
