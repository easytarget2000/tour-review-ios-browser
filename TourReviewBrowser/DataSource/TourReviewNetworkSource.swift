import Siesta

class TourReviewNetworkSource {
    
    fileprivate static let apiBaseURL
        = ConfigurationReader.value(forKey: .tourReviewAPIBaseURL)
    
    fileprivate static let numOfItemsPerPageParam = "count"
    
    fileprivate static let pageParam = "page"
    
    fileprivate static let sortOptionParam = "sortBy"
    
    fileprivate static let sortDirParam = "direction"
    
    fileprivate let siestaService = Service(
        baseURL: TourReviewNetworkSource.apiBaseURL,
        standardTransformers: []
    )
    
    weak var delegate: TourReviewSourceDelegate?
    
    var itemsPerPage = 10
    
    var counter = 1
    
    var regionIDPath = ""
    
    var tourIDPath = ""
    
    var sortOption: TourReviewSortOption?

    var sortDir: TourReviewSortDirection?
    
    fileprivate var isLoading = false
    
    fileprivate var reviewsPages = [Int: [TourReview]]()
    
    fileprivate var numOfPages = 0
        
    init() {
        #if DEBUG
            SiestaLog.Category.enabled =  [.network]
        #endif
        let decoder = JSONDecoder()

        siestaService.configureTransformer("**") {
            try decoder.decode(TourReviewAPIResponse.self, from: $0.content)
        }
    }
    
    func loadReviews(amount: Int) {
        guard !isLoading else {
            return
        }
        
        reviewsPages = [Int: [TourReview]]()
        isLoading = true
        numOfPages = (amount / itemsPerPage) + 1
        for page in 0 ..< numOfPages {
            loadReviewsOfPage(page)
        }
    }
    
    fileprivate func loadReviewsOfPage(_ page: Int) {
        let path = "/\(regionIDPath)/\(tourIDPath)/reviews.json"
        var resource = siestaService
            .resource(path)
            .withParam(
                TourReviewNetworkSource.numOfItemsPerPageParam,
                String(itemsPerPage)
            )
            .withParam(TourReviewNetworkSource.pageParam, String(page))
        
        if let sortOption = sortOption, let sortDir = sortDir {
            resource = resource.withParam(
                TourReviewNetworkSource.sortOptionParam,
                TourReviewNetworkSource.sortOptionParamValue(sortOption)
            )
            resource = resource.withParam(
                TourReviewNetworkSource.sortDirParam,
                TourReviewNetworkSource.sortDirParamValue(sortDir)
            )
        }
        
        resource.addObserver(owner: self) {
            (resource, event) in
            guard let response: TourReviewAPIResponse = resource.typedContent()
                else {
                return
            }
            
            self.reviewsPages[page] = response.reviews
            let totalNumOfReviews = response.totalNumOfReviews
            self.notifyDelegateIfFinished(maxNumOfReviews: totalNumOfReviews)
        }.loadIfNeeded()
    }
    
    fileprivate static func sortOptionParamValue(
        _ sortOrder: TourReviewSortOption
        ) -> String {
        switch sortOrder {
        case .rating:
            return "rating"
        case .date:
            return "date_of_review"
        }
    }
    
    fileprivate static func sortDirParamValue(
        _ sortOrder: TourReviewSortDirection
    ) -> String {
        switch sortOrder {
        case .ascending:
            return "asc"
        case .descending:
            return "desc"
        }
    }
    
    fileprivate func notifyDelegateIfFinished(maxNumOfReviews: Int) {
        var reviews = [TourReview]()
        for page in 0 ..< numOfPages {
            guard let reviewsOfPage = reviewsPages[page] else {
                return
            }
            
            reviews.append(contentsOf: reviewsOfPage)
        }
        
        let didReachEnd = reviews.count == maxNumOfReviews
        
        delegate?.didFetchTourReviews(reviews, didReachEnd: didReachEnd)
        isLoading = false
    }
}

