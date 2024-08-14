import UIKit

class ExpandableTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var expandedContentView: UIView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var completedBTN: CheckboxButton!
    
    // MARK: - Properties
    var isExpanded: Bool = false {
        didSet {
            UIView.animate(withDuration: 0.3) {
                self.expandedContentView.isHidden = !self.isExpanded
            }
        }
    }

    // MARK: - Initialization
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initial setup
        expandedContentView.isHidden = true // Start with the expanded content hidden
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
