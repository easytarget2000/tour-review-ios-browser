import Siesta

class TourReviewNetworkSource {
    
    fileprivate static let apiBaseURL
        = ConfigurationReader.value(forKey: .tourReviewAPIBaseURL)
    
    fileprivate static let numOfItemsPerPageParam = "count"
    
    fileprivate static let pageParam = "page"
    
    fileprivate static let sortOrderParam = "sortBy"
    
    fileprivate let siestaService = Service(
        baseURL: TourReviewNetworkSource.apiBaseURL,
        standardTransformers: []
    )
    
    weak var delegate: TourReviewSourceDelegate?
    
    var itemsPerPage = 10
    
    var counter = 1
    
    var regionIDPath = ""
    
    var tourIDPath = ""
    
    var sortOrder: TourReviewSortOrder?
        
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
        loadReviewsForPage(
            0,
            numOfPages: (amount / itemsPerPage) + 1,
            previousReviews: [TourReview]()
        )
    }
    
    fileprivate func loadReviewsForPage(
        _ page: Int,
        numOfPages: Int,
        previousReviews: [TourReview]
    ) {
        guard page < numOfPages else {
            delegate?.didFetchTourReviews(previousReviews)
            return
        }
        
        let path = "/\(regionIDPath)/\(tourIDPath)/reviews.json"
        let resource = siestaService
            .resource(path)
            .withParam(
                TourReviewNetworkSource.numOfItemsPerPageParam,
                String(itemsPerPage)
            )
            .withParam(TourReviewNetworkSource.pageParam, String(page))
        
        if let sortOrder = sortOrder {
            let _ = resource.withParam(
                TourReviewNetworkSource.sortOrderParam,
                TourReviewNetworkSource.sortOrderParamValue(sortOrder)
            )
        }
        
        var previousReviews = previousReviews
        resource.addObserver(owner: self) {
            (resource, event) in
            guard let response: TourReviewAPIResponse = resource.typedContent()
                else {
                return
            }
            
            previousReviews.append(contentsOf: response.reviews)
            self.loadReviewsForPage(
                page + 1,
                numOfPages: numOfPages,
                previousReviews: previousReviews
            )
        }.loadIfNeeded()
    }
    
    fileprivate static func sortOrderParamValue(
        _ sortOrder: TourReviewSortOrder
    ) -> String {
        switch sortOrder {
        case .ascending:
            return "ASC"
        case .descending:
            return "DESC"
        }
    }
}

