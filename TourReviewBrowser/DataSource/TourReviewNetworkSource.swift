import Siesta

let TourReviewNetworkSource = _TourReviewNetworkSource()

class _TourReviewNetworkSource {
    
    fileprivate static let apiBaseURL
        = ConfigurationReader.value(forKey: .tourReviewAPIBaseURL)
    
    fileprivate static let maxNumOfResultsParam = "count"
    
    fileprivate static let resultsPageParam = "page"
    
    fileprivate let siestaService = Service(
        baseURL: _TourReviewNetworkSource.apiBaseURL,
        standardTransformers: []
    )
    
    weak var delegate: TourReviewSourceDelegate?
    
    var maxNumOfReviews = 2
    
    var page = 0
    
    var rating: Int?
    
    init() {
        #if DEBUG
//            SiestaLog.Category.enabled = .all
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
        
        resource.addObserver(self)
        resource.loadIfNeeded()
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
