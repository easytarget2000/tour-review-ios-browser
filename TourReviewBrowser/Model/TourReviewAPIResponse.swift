struct TourReviewAPIResponse: Codable {
    
//    let success: Bool
    
    let totalNumOfComments: Int
    
    enum CodingKeys: String, CodingKey {
//        case success = "status"
        case totalNumOfComments = "total_reviews_comments"
    }
}
