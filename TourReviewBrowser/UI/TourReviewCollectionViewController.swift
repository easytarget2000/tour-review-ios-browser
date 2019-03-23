import UIKit

class TourReviewCollectionViewController: UICollectionViewController {
    
    fileprivate var reviews: [TourReview]?
    
    fileprivate var numOfReviewCells: Int {
        get {
            guard let reviews = reviews else {
                return 0
            }
            
            return reviews.count
        }
    }
    
    static func newInstance() -> TourReviewCollectionViewController {
        return self.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
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
    
    fileprivate func populateCell(
        _ cell: TourReviewCollectionViewCell,
        atRow row: Int
    ) -> TourReviewCollectionViewCell {
        return cell
    }
}
