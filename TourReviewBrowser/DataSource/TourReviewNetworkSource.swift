import Siesta

let TourReviewNetworkSource = _TourReviewNetworkSource()

class _TourReviewNetworkSource {
    
    fileprivate static let apiBaseURL
        = ConfigurationReader.value(forKey: .tourReviewAPIBaseURL)
    
    fileprivate static let maxNumOfResultsParam = "count"
    
    fileprivate static let resultsPageParam = "page"
    
    fileprivate static let sortOrderParam = "sortBy"
    
    fileprivate let siestaService = Service(
        baseURL: _TourReviewNetworkSource.apiBaseURL,
        standardTransformers: []
    )
    
    weak var delegate: TourReviewSourceDelegate?
    
    var maxNumOfReviews = 50
    
    var page = 0
    
    var rating: Int?
    
    init() {
        #if DEBUG
            SiestaLog.Category.enabled =  [.network]
        #endif
        let decoder = JSONDecoder()

        siestaService.configureTransformer("**") {
            try decoder.decode(TourReviewAPIResponse.self, from: $0.content)
        }
    }
    
    func loadReviews(
        regionIDPath: String,
        tourIDPath: String,
        sortOrder: TourReviewSortOrder?,
        forDelegate delegate: TourReviewSourceDelegate?
    ) {
        self.delegate = delegate
        
        let path = "/\(regionIDPath)/\(tourIDPath)/reviews.json"
        let resource = siestaService
            .resource(path)
            .withParam(
                _TourReviewNetworkSource.maxNumOfResultsParam,
                String(maxNumOfReviews)
            )
            .withParam(_TourReviewNetworkSource.resultsPageParam, String(page))
        
        if let sortOrder = sortOrder {
            let _ = resource.withParam(
                _TourReviewNetworkSource.sortOrderParam,
                _TourReviewNetworkSource.sortOrderParamValue(sortOrder)
            )
        }
        
        resource.addObserver(self)
        resource.loadIfNeeded()
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

// MARK: - Siesta ResourceObserver

extension _TourReviewNetworkSource: ResourceObserver {
    
    func resourceChanged(_ resource: Resource, event: ResourceEvent) {
        #if DEBUG
            NSLog(event._objc_stringForm)
        #endif
        if let response: TourReviewAPIResponse = resource.typedContent() {
            #if DEBUG
                NSLog(response.reviews.debugDescription)
            #endif
            delegate?.didFetchTourReviews(response.reviews)
        }
    }
    
}
