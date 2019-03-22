import Siesta

class TourReviewNetworkLoader {
    
    fileprivate static let apiBaseURL
        = ConfigurationReader.value(forKey: .apiBaseURL)
    
    let siestaService = Service(baseURL: TourReviewNetworkLoader.apiBaseURL)
    
    func loadReviews() {
        let path = "berlin-l17/tempelhof-2-hour-airport-history-tour-berlin-airlift-more-t23776"

//        siestaService.configureTransformer(path) { (<#Entity<I>#>) -> O? in
//            <#code#>
//        }
        
        siestaService.resource(path).addObserver(self)
    }
}

// MARK: - Siesta ResourceObserver

extension TourReviewNetworkLoader: ResourceObserver {
    
    func resourceChanged(_ resource: Resource, event: ResourceEvent) {
        print(resource.description)
    }
    
}
