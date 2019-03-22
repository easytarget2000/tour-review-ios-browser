import UIKit

class ViewController: UIViewController {
    
    var regionIDPath = "berlin-l17"
    
    var tourIDPath
        = "tempelhof-2-hour-airport-history-tour-berlin-airlift-more-t23776"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadReviews()
    }
    
    fileprivate func loadReviews() {
        TourReviewNetworkLoader.loadReviews(
            regionIDPath: regionIDPath,
            tourIDPath: tourIDPath,
            forDelegate: self
        )
    }
}

// MARK: - TourReviewSourceDelegate

extension ViewController: TourReviewSourceDelegate {
    
    func didFetchTourReviews(_ reviews: [TourReview]?) {
        
    }
}
