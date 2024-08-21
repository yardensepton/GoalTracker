import UIKit

protocol ExpandableTableViewCellDelegate: AnyObject {
    func checkboxButton(_ button: CheckboxButton, didChangeState isChecked: Bool, at indexPath: IndexPath)
}

class ExpandableTableViewCell: UITableViewCell, CheckboxButtonDelegate{

    // MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var expandedContentView: UIView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var completedBTN: CheckboxButton!
    
    weak var delegate: ExpandableTableViewCellDelegate?
    var indexPath: IndexPath?
    
    // MARK: - Properties
    var isExpanded: Bool = false {
        didSet {
            UIView.animate(withDuration: 0.3) {
                self.expandedContentView.isHidden = !self.isExpanded
            }
        }
    }
    
    func checkboxButton(_ button: CheckboxButton, didChangeState isChecked: Bool) {
        print("CheckboxButton delegate method called with state: \(isChecked)")
        guard let indexPath = indexPath else {
              print("IndexPath is nil in checkboxButton delegate")
              return
          }
        delegate?.checkboxButton(button, didChangeState: isChecked, at: indexPath)

    }



    // MARK: - Initialization
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initial setup
        expandedContentView.isHidden = true // Start with the expanded content hidden
        completedBTN.delegate = self // Set the delegate to self
    }

    func configure(with task: Task, at indexPath: IndexPath, isExpanded: Bool) {
            self.indexPath = indexPath
            titleLabel.text = task.title
            descriptionLabel.text = task.description
            dateLabel.text = task.completionDate
            completedBTN.isChecked = task.isCompleted // Bind checkbox state to model
            self.isExpanded = isExpanded
        }
}
