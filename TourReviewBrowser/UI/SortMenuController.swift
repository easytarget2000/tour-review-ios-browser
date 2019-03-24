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
        
        let asccendingTitle = NSLocalizedString(
            "TourReviewsTableAscendingSortOption",
            comment: "Asscending"
        )
        let sortAscendingAction = UIAlertAction(
            title: asccendingTitle,
            style: .default,
            handler: {
                _ in
                self.selectAscending()
            }
        )
        addAction(sortAscendingAction)
        
        let descendingTitle = NSLocalizedString(
            "TourReviewsTableDescendingSortOption",
            comment: "Descending"
        )
        let sortDescendingAction = UIAlertAction(
            title: descendingTitle,
            style: .default,
            handler: {
                _ in
                self.selectDescending()
            }
        )
        addAction(sortDescendingAction)
    }
    
    func close() {
        dismiss(animated: true, completion: nil)
    }
    
    fileprivate func selectAscending() {
        delegate?.sortMenuController(self, requestedSortOrder: .ascending)
    }
    
    fileprivate func selectDescending() {
        delegate?.sortMenuController(self, requestedSortOrder: .descending)
    }
}
