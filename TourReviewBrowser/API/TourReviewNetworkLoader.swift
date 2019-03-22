import Siesta

let TourReviewNetworkLoader = _TourReviewNetworkLoader()

class _TourReviewNetworkLoader {
    
    fileprivate static let apiBaseURL
        = ConfigurationReader.value(forKey: .tourReviewAPIBaseURL)
    
    let siestaService = Service(baseURL: _TourReviewNetworkLoader.apiBaseURL)
    
    var maxNumOfReviews = 5
    
    var page = 0
    
    var rating: Int?
    
    init() {
        #if DEBUG
            SiestaLog.Category.enabled = [.network]
        #endif
        
        siestaService.configureTransformer(
            "**",
            contentTransform: {
                try JSONDecoder().decode(<#T##type: Decodable.Protocol##Decodable.Protocol#>, from: <#T##Data#>)
            }
        )
    }
    
    func loadReviews() {
        let path = "/berlin-l17/tempelhof-2-hour-airport-history-tour-berlin-airlift-more-t23776/reviews.json"

//        siestaService.configureTransformer(path) { (<#Entity<I>#>) -> O? in
//            <#code#>
//        }
        
        let resource = siestaService.resource(path)
        resource.addObserver(self)
        resource.loadIfNeeded()
    }
}

// MARK: - Siesta ResourceObserver

extension _TourReviewNetworkLoader: ResourceObserver {
    
    func resourceChanged(_ resource: Resource, event: ResourceEvent) {
        NSLog(event._objc_stringForm)
        let dict = resource.jsonDict
        NSLog(dict.description)
    }
    
}
