import AXRatingView

class TourReviewCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "TourReviewCollectionViewCell"
    
    static let nibName = "TourReviewCollectionViewCell"
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var ratingView: AXRatingView!
    
    @IBOutlet weak var messageLabel: UILabel!
    
    func populateWithViewModel(_ viewModel: TourReviewViewModel) {
        titleLabel.text = viewModel.title
        dateLabel.text = viewModel.date
        ratingView.value = viewModel.rating
        messageLabel.text = viewModel.message
    }
    
}
