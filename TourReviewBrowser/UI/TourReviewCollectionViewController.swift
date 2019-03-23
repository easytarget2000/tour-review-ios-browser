import UIKit

class TourReviewCollectionViewController: UICollectionViewController {
    
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
        setupCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadReviews()
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
    
    // MARK: - Implementations
    
    fileprivate func setup() {
        view.backgroundColor = .white
        collectionView.backgroundColor = .clear
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
    
    fileprivate func loadReviews() {
        TourReviewNetworkSource.loadReviews(
            regionIDPath: regionIDPath,
            tourIDPath: tourIDPath,
            forDelegate: self
        )
    }
    
    fileprivate func populateCell(
        _ cell: TourReviewCollectionViewCell,
        atRow row: Int
    ) -> TourReviewCollectionViewCell {
        return cell
    }
    
    fileprivate func refreshContentView() {
        collectionView.reloadData()
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
        return CGSize(width: collectionView.frame.width, height: 50)
    }
    
}

// MARK: - TourReviewSourceDelegate

extension TourReviewCollectionViewController: TourReviewSourceDelegate {
    
    func didFetchTourReviews(_ reviews: [TourReview]?) {
        self.reviews = reviews
    }
}
