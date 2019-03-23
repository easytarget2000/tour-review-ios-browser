struct TourReviewViewModel {
    
    fileprivate static let numOfStars = Float(5)
    
    let review: TourReview
    
    var title: String? {
        get {
            return review.title
        }
    }
    
    var additionalInfo: String {
        get {
            return "\(review.authorName)\n\(review.formattedDate)"
        }
    }
    
    var rating: Float {
        get {
            return review.rating * TourReviewViewModel.numOfStars
        }
    }
    
    var message: String {
        get {
            return review.message
        }
    }
    
}
