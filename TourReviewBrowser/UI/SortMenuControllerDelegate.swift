import Foundation

protocol SortMenuControllerDelegate: NSObjectProtocol {
    
    func sortMenuController(
        _ sortMenuController: SortMenuController,
        requestedSortOrder sortOrder: TourReviewSortDir
    )
    
}
