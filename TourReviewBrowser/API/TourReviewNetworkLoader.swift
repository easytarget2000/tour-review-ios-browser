import Siesta

let TourReviewNetworkLoader = _TourReviewNetworkLoader()

class _TourReviewNetworkLoader {
    
    fileprivate static let apiBaseURL
        = ConfigurationReader.value(forKey: .tourReviewAPIBaseURL)
    
    fileprivate static let maxNumOfResultsParam = "count"
    
    fileprivate static let resultsPageParam = "page"
    
    fileprivate let siestaService = Service(
        baseURL: _TourReviewNetworkLoader.apiBaseURL,
        standardTransformers: []
    )
    
    var maxNumOfReviews = 2
    
    var page = 0
    
    var rating: Int?
    
    init() {
        #if DEBUG
            SiestaLog.Category.enabled = .all
        #endif
        let decoder = JSONDecoder()

        siestaService.configureTransformer("**") {
            try decoder.decode(TourReviewAPIResponse.self, from: $0.content)
        }
    }
    
    func loadReviews(regionIDPath: String, tourIDPath: String) {
        let path = "/\(regionIDPath)/\(tourIDPath)/reviews.json"
        
        let resource = siestaService
            .resource(path)
            .withParam(
                _TourReviewNetworkLoader.maxNumOfResultsParam,
                String(maxNumOfReviews)
            )
            .withParam(_TourReviewNetworkLoader.resultsPageParam, String(page))
        
        resource.addObserver(self)
        resource.loadIfNeeded()
    }
}

// MARK: - Siesta ResourceObserver

extension _TourReviewNetworkLoader: ResourceObserver {
    
    func resourceChanged(_ resource: Resource, event: ResourceEvent) {
        let dict = resource.jsonDict
        NSLog(dict.description)
        if let response: TourReviewAPIResponse = resource.typedContent() {
            NSLog(String(response.totalNumOfComments))
        }
    }
    
}
