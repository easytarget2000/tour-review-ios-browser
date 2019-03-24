import UIKit

class TourReviewNavigationController: UINavigationController {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(
        nibName nibNameOrNil: String?,
        bundle nibBundleOrNil: Bundle?
    ) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    init() {
        super.init(
            rootViewController: TourReviewTableViewController.newInstance(
                regionIDPath: "berlin-l17",
                tourIDPath: "tempelhof-2-hour-airport-history-tour-berlin-airlift-more-t23776"
            )
        )
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    fileprivate func setup() {
        view.backgroundColor = .white
    }
}
