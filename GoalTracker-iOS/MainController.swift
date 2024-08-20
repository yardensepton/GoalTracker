import UIKit
import FirebaseAuth
import FirebaseDatabase



class MainController: UIViewController, UITableViewDelegate, UITableViewDataSource, ExpandableTableViewCellDelegate {
    
    @IBOutlet weak var table: UITableView!
    
    @IBOutlet weak var newTaskBTN: UIButton!
    
    @IBOutlet weak var exitBtn: UIButton!
    
    var Tasks: [Task] = []
    
    var expandedIndexSet: IndexSet = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        table.dataSource = self
        table.delegate = self
    
        if let currentUser = UserManager.shared.currentUser {
            print(currentUser.uid)
            DataManager().getDataFromUid(for: String(currentUser.uid)) { [weak self] fetchedTasks in
                self?.Tasks = fetchedTasks
                self?.table.reloadData()
            }
        } else {
            print("No user was logged in")
        }
    }

    // UITableViewDataSource methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Tasks.count
    }

   
    @IBAction func signOutPress(_ sender: Any) {
        let res =  UserManager.shared.signOutUser()
        if res{
            navigationController?.popToRootViewController(animated: true)
      
        }
    }
    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "ExpandableCell", for: indexPath) as! ExpandableTableViewCell
//
//        let task = Tasks[indexPath.row]
//        cell.titleLabel.text = task.title
//        cell.descriptionLabel.text = task.description
//        cell.dateLabel.text = task.completionDate
//        cell.completedBTN.isChecked = task.isCompleted
//
//        cell.isExpanded = expandedIndexSet.contains(indexPath.row)
//
//        return cell
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExpandableCell", for: indexPath) as! ExpandableTableViewCell

        let task = Tasks[indexPath.row]
        cell.titleLabel.text = task.title
        cell.descriptionLabel.text = task.description
        cell.dateLabel.text = task.completionDate
        cell.completedBTN.isChecked = task.isCompleted

        cell.indexPath = indexPath // Set the indexPath here
        cell.delegate = self // Ensure the delegate is set

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
            return 70 // Default height for collapsed state
        }
    }
    
    
//    func checkboxButton(_ button: CheckboxButton, didChangeState isChecked: Bool, at indexPath: IndexPath) {
//        print(isChecked)
//        // Update your task model based on the checkbox change
//        Tasks[indexPath.row].isCompleted = isChecked
//        DataManager().self.updateTaskCompletion(taskID: Tasks[indexPath.row].taskID,isChecked: isChecked)
//
//    }
    
    // ExpandableTableViewCellDelegate method
     func checkboxButton(_ button: CheckboxButton, didChangeState isChecked: Bool, at indexPath: IndexPath) {
         print("Checkbox state changed to \(isChecked) for task at \(indexPath.row)")

         // Update your task model based on the checkbox change
         Tasks[indexPath.row].isCompleted = isChecked

         // Update the database with the new state
         let taskID = Tasks[indexPath.row].taskID // Assuming Task has a taskID property
         print("in main controller \(taskID)")
         DataManager().updateTaskCompletion(taskID: taskID, isChecked: isChecked)
         
         // Optionally, reload the cell to reflect the change
         table.reloadRows(at: [indexPath], with: .none)
     }
}
