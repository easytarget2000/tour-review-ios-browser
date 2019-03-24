import ObjectiveC

protocol TourReviewSourceDelegate: NSObjectProtocol {
    func didFetchTourReviews(_ reviews: [TourReview]?, didReachEnd: Bool)
}
