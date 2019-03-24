import Foundation

protocol SortMenuControllerDelegate: NSObjectProtocol {
    
    func sortMenuController(
        _ sortMenuController: SortMenuController,
        requestedSortOption sortOption: TourReviewSortOption,
        direction: TourReviewSortDirection
    )
    
}
