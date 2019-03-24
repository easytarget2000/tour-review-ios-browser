import AXRatingView

class TourReviewCollectionViewCell: UITableViewCell {
    
    static let identifier = "TourReviewCollectionViewCell"
    
    static let nibName = "TourReviewCollectionViewCell"
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var ratingView: AXRatingView!
    
    @IBOutlet weak var messageLabel: UILabel!
    
    @IBOutlet weak var additionalInfoLabel: UILabel!
    
    func populateWithViewModel(_ viewModel: TourReviewViewModel) {
        if let title = viewModel.title {
            titleLabel.text = title
            titleLabel.isHidden = false
        } else {
            titleLabel.isHidden = true
        }
        
        ratingView.value = viewModel.rating
        messageLabel.text = viewModel.message
        additionalInfoLabel.text = viewModel.additionalInfo
    }
    
}
