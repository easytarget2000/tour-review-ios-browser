import UIKit

class TourReviewTableViewController: UITableViewController {
    
    fileprivate static let estimatedRowHeight = CGFloat(256)
    
    fileprivate static let fadeInDuration = TimeInterval(0.15)
    
    fileprivate static let displayToLoadingItemCountDelta = 5
    
    fileprivate let networkSource = TourReviewNetworkSource()
    
    fileprivate var regionIDPath: String!
    
    fileprivate var tourIDPath: String!
    
    fileprivate var reviews: [TourReview]? {
        didSet {
            refreshContentView()
            stopRefreshControl()
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
    ) -> TourReviewTableViewController {
        let instance = TourReviewTableViewController()
        instance.regionIDPath = regionIDPath
        instance.tourIDPath = tourIDPath
        return instance
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        fadeOut()
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
        addSortButton()
        setupTableView()
        setupRefreshControl()
        setupNetworkSource()
    }
    
    fileprivate func setTitle() {
        let title = NSLocalizedString(
            "TourReviewCollectionTitle",
            comment: "Reviews"
        )
        self.title = title
    }
    
    fileprivate func addSortButton() {
        let sortButtonTitle = NSLocalizedString(
            "TourReviewsTableSortButton",
            comment: "Sort"
        )
        let sortButton = UIBarButtonItem(
            title: sortButtonTitle,
            style: .plain,
            target: self,
            action: #selector(showSortMenu)
        )
        
        navigationItem.rightBarButtonItem = sortButton
    }
    
    @objc func showSortMenu() {
        
    }
    
    fileprivate func setupTableView() {
        tableView.backgroundColor = .clear
        tableView.tableFooterView = UIView()
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
    
    fileprivate func setupRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(
            self,
            action: #selector(reloadReviews),
            for: .valueChanged
        )
    }
    
    fileprivate func stopRefreshControl() {
        refreshControl?.endRefreshing()
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
            + TourReviewTableViewController.displayToLoadingItemCountDelta
        
        let loadMore = (reviews?.count ?? 0) < minNumberOfReviews
        if loadMore {
            loadReviews(amount: minNumberOfReviews)
        }
    }
    
    @objc func reloadReviews() {
        loadReviews(amount:
            TourReviewTableViewController.displayToLoadingItemCountDelta
        )
    }
    
    fileprivate func loadReviews(amount: Int) {
        networkSource.loadReviews(amount: amount)
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
        fadeIn()
        tableView.reloadData()
    }
    
    fileprivate func acknowledgeCell(index: Int) {
        if index > numOfCellsDisplayed {
            numOfCellsDisplayed = index
            loadReviewsIfNeeded()
        }
    }
    
    fileprivate func fadeOut() {
        view.alpha = 0
    }
    
    fileprivate func fadeIn() {
        guard view.alpha < 1 else {
            return
        }
        
        UIView.animate(
            withDuration: TourReviewTableViewController.fadeInDuration,
            animations: {
                self.view.alpha = 1
            }
        )
    }
}

// MARK: - TourReviewSourceDelegate

extension TourReviewTableViewController: TourReviewSourceDelegate {
    
    func didFetchTourReviews(_ reviews: [TourReview]?, didReachEnd: Bool) {
        self.reviews = reviews
        self.didReachEnd = didReachEnd
    }
}
