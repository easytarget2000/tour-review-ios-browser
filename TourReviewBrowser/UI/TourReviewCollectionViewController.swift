import UIKit

class TourReviewCollectionViewController: UICollectionViewController {
    
    fileprivate static let cellHeight = CGFloat(256)
    
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
        let collectionViewLayout = UICollectionViewFlowLayout()
        let instance = TourReviewCollectionViewController(
            collectionViewLayout: collectionViewLayout
        )
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

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return numOfReviewCells
    }

    override func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: TourReviewCollectionViewCell.identifier,
            for: indexPath
        ) as! TourReviewCollectionViewCell
    
        return populateCell(cell, atRow: indexPath.row)
    }
    
    override func collectionView(
        _ collectionView: UICollectionView,
        willDisplay cell: UICollectionViewCell,
        forItemAt indexPath: IndexPath
    ) {
        acknowledgeCell(index: indexPath.row)
    }
    
    // MARK: - Implementations
    
    fileprivate func setup() {
        view.backgroundColor = .white
        collectionView.backgroundColor = .clear
        setTitle()
        setupCollectionView()
        setupNetworkSource()
    }
    
    fileprivate func setTitle() {
        let title = NSLocalizedString(
            "TourReviewCollectionTitle",
            comment: "Reviews"
        )
        self.title = title
    }
    
    fileprivate func setupCollectionView() {
        let reviewCellNib = UINib(
            nibName: TourReviewCollectionViewCell.nibName,
            bundle: nil
        )
        collectionView.register(
            reviewCellNib,
            forCellWithReuseIdentifier: TourReviewCollectionViewCell.identifier
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
        _ cell: TourReviewCollectionViewCell,
        atRow row: Int
    ) -> TourReviewCollectionViewCell {
        let review = reviews![row]
        let reviewViewModel = TourReviewViewModel(review: review)
        cell.populateWithViewModel(reviewViewModel)
        return cell
    }
    
    fileprivate func refreshContentView() {
        collectionView.reloadData()
    }
    
    fileprivate func acknowledgeCell(index: Int) {
        if index > numOfCellsDisplayed {
            numOfCellsDisplayed = index
            loadReviewsIfNeeded()
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension TourReviewCollectionViewController:
UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return cellSize(availableWidth: collectionView.frame.width)
    }
    
    fileprivate func cellSize(availableWidth: CGFloat) -> CGSize {
        let cellHeight = TourReviewCollectionViewController.cellHeight
        return CGSize(width: availableWidth, height: cellHeight)
    }
}

// MARK: - TourReviewSourceDelegate

extension TourReviewCollectionViewController: TourReviewSourceDelegate {
    
    func didFetchTourReviews(_ reviews: [TourReview]?, didReachEnd: Bool) {
        self.reviews = reviews
        self.didReachEnd = didReachEnd
    }
}
