import UIKit

class SortMenuController: UIAlertController {
    
    weak var delegate: SortMenuControllerDelegate?
    
    override var preferredStyle: UIAlertController.Style {
        get {
            return .actionSheet
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    fileprivate func setup() {
        
        let asccendingDateTitle = NSLocalizedString(
            "TourReviewsTableAscendingDateOption",
            comment: "Date Ascending"
        )
        let sortAscendingDateAction = UIAlertAction(
            title: asccendingDateTitle,
            style: .default,
            handler: {
                _ in
                self.selectAscendingDate()
            }
        )
        addAction(sortAscendingDateAction)
        
        let descendingDateTitle = NSLocalizedString(
            "TourReviewsTableDescendingDateOption",
            comment: "Date Descending"
        )
        let sortDescendingDateAction = UIAlertAction(
            title: descendingDateTitle,
            style: .default,
            handler: {
                _ in
                self.selectDescendingDate()
            }
        )
        addAction(sortDescendingDateAction)
        
        let asccendingRatingTitle = NSLocalizedString(
            "TourReviewsTableAscendingRatingOption",
            comment: "Rating Asscending"
        )
        let sortAscendingRatingAction = UIAlertAction(
            title: asccendingRatingTitle,
            style: .default,
            handler: {
                _ in
                self.selectAscendingRating()
            }
        )
        addAction(sortAscendingRatingAction)
        
        let descendingRatingTitle = NSLocalizedString(
            "TourReviewsTableDescendingRatingOption",
            comment: "Rating Descending"
        )
        let sortDescendingRatingAction = UIAlertAction(
            title: descendingRatingTitle,
            style: .default,
            handler: {
                _ in
                self.selectDescendingRating()
            }
        )
        addAction(sortDescendingRatingAction)
    }
    
    func close() {
        dismiss(animated: true, completion: nil)
    }
    
    fileprivate func selectAscendingDate() {
        delegate?.sortMenuController(
            self,
            requestedSortOption: .date,
            direction: .ascending
        )
    }
    
    fileprivate func selectDescendingDate() {
        delegate?.sortMenuController(
            self,
            requestedSortOption: .date,
            direction: .descending
        )
    }
    
    fileprivate func selectAscendingRating() {
        delegate?.sortMenuController(
            self,
            requestedSortOption: .rating,
            direction: .ascending
        )
    }
    
    fileprivate func selectDescendingRating() {
        delegate?.sortMenuController(
            self,
            requestedSortOption: .rating,
            direction: .descending
        )
    }
}
