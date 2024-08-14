import UIKit
import FirebaseAuth

class MainController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var table: UITableView!
    
    var currentUser: User?
    
    var Tasks: [Task] = []
    
    var expandedIndexSet: IndexSet = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        let user = UserManager.shared.getCurrentUser()
        
        Tasks = [
            Task(title: "Android B", description: "Final Task", userID: (user?.email)!, completionDate: "26/08/24"),
            Task(title: "iOS Programming", description: "Final Task", userID: (user?.email)!, completionDate: "26/08/24")
        ]
        table.delegate = self
        table.dataSource = self
    }

    // UITableViewDataSource methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Tasks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExpandableCell", for: indexPath) as! ExpandableTableViewCell

        let task = Tasks[indexPath.row]
        cell.titleLabel.text = task.title
        cell.descriptionLabel.text = task.description
        cell.dateLabel.text = task.completionDate

        cell.isExpanded = expandedIndexSet.contains(indexPath.row)

        return cell
    }

    // UITableViewDelegate method for handling expansion
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        if expandedIndexSet.contains(indexPath.row) {
            expandedIndexSet.remove(indexPath.row)
        } else {
            expandedIndexSet.insert(indexPath.row)
        }

        tableView.reloadRows(at: [indexPath], with: .automatic)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if expandedIndexSet.contains(indexPath.row) {
            return UITableView.automaticDimension // Adjust based on content size
        } else {
            return 60 // Default height for collapsed state
        }
    }
}
