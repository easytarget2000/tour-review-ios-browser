struct TourReviewViewModel {
    
    fileprivate static let numOfStars = Float(5)
    
    let review: TourReview
    
    var title: String {
        get {
            return review.title ?? ""
        }
    }
    
    var date: String {
        get {
            return review.formattedDate
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
