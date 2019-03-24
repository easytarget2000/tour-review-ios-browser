import UIKit

class TourReviewCollectionViewController: UITableViewController {
    
    fileprivate static let estimatedRowHeight = CGFloat(256)
    
    fileprivate static let displayToLoadingItemCountDelta = 5
    
    fileprivate let networkSource = TourReviewNetworkSource()
    
    fileprivate var regionIDPath: String!
    
    fileprivate var tourIDPath: String!
    
    fileprivate var reviews: [TourReview]? {
        didSet {
            refreshContentView()
        }
    }
    
    fileprivate var numOfReviewCells: Int {
        get {
            guard let reviews = reviews else {
                return 0
            }
            
            return reviews.count
        }
    }
    
    fileprivate var numOfCellsDisplayed = 0
    
    fileprivate var didReachEnd = false
    
    static func newInstance(
        regionIDPath: String,
        tourIDPath: String
    ) -> TourReviewCollectionViewController {
        let instance = TourReviewCollectionViewController()
        instance.regionIDPath = regionIDPath
        instance.tourIDPath = tourIDPath
        return instance
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadReviewsIfNeeded()
    }

    // MARK: UITableViewDataSource
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return numOfReviewCells
    }
    
    override func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: TourReviewCell.identifier,
            for: indexPath
        ) as! TourReviewCell
    
        return populateCell(cell, atRow: indexPath.row)
    }
    
    override func tableView(
        _ tableView: UITableView,
        willDisplay cell: UITableViewCell,
        forRowAt indexPath: IndexPath
    ) {
        acknowledgeCell(index: indexPath.row)
    }
    
    // MARK: - Implementations
    
    fileprivate func setup() {
        view.backgroundColor = .white
        setTitle()
        setupTableView()
        setupNetworkSource()
    }
    
    fileprivate func setTitle() {
        let title = NSLocalizedString(
            "TourReviewCollectionTitle",
            comment: "Reviews"
        )
        self.title = title
    }
    
    fileprivate func setupTableView() {
        tableView.backgroundColor = .clear
//        tableView.estimatedRowHeight
//            = TourReviewCollectionViewController.estimatedRowHeight
        tableView.rowHeight = UITableView.automaticDimension

        let reviewCellNib = UINib(
            nibName: TourReviewCell.nibName,
            bundle: nil
        )
        tableView.register(
            reviewCellNib,
            forCellReuseIdentifier: TourReviewCell.identifier
        )
        clearsSelectionOnViewWillAppear = false
    }
    
    fileprivate func setupNetworkSource() {
        networkSource.delegate = self
        networkSource.regionIDPath = regionIDPath
        networkSource.tourIDPath = tourIDPath
    }
    
    fileprivate func loadReviewsIfNeeded() {
        guard !didReachEnd else {
            return
        }
        
        let minNumberOfReviews = numOfCellsDisplayed
            + TourReviewCollectionViewController.displayToLoadingItemCountDelta
        
        let loadMore = (reviews?.count ?? 0) < minNumberOfReviews
        if loadMore {
            networkSource.loadReviews(amount: minNumberOfReviews)
        }
    }
    
    fileprivate func populateCell(
        _ cell: TourReviewCell,
        atRow row: Int
    ) -> TourReviewCell {
        let review = reviews![row]
        let reviewViewModel = TourReviewViewModel(review: review)
        cell.populateWithViewModel(reviewViewModel)
        return cell
    }
    
    fileprivate func refreshContentView() {
        tableView.reloadData()
    }
    
    fileprivate func acknowledgeCell(index: Int) {
        if index > numOfCellsDisplayed {
            numOfCellsDisplayed = index
            loadReviewsIfNeeded()
        }
    }
}

// MARK: - TourReviewSourceDelegate

extension TourReviewCollectionViewController: TourReviewSourceDelegate {
    
    func didFetchTourReviews(_ reviews: [TourReview]?, didReachEnd: Bool) {
        self.reviews = reviews
        self.didReachEnd = didReachEnd
    }
}
