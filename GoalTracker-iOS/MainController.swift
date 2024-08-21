import UIKit
import FirebaseAuth
import FirebaseDatabase
import Lottie


class MainController: UIViewController, UITableViewDelegate, UITableViewDataSource, ExpandableTableViewCellDelegate {
    

    @IBOutlet weak var lottie: LottieAnimationView!
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var newTaskBTN: UIButton!
    
    @IBOutlet weak var exitBtn: UIButton!
    var animationView: LottieAnimationView = .init()
    
    var Tasks: [Task] = []
    
    var expandedIndexSet: IndexSet = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        table.dataSource = self
        table.delegate = self
        configureLottieAnimation()
        
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))
        table.addGestureRecognizer(longPressGesture)

        if let currentUser = UserManager.shared.currentUser {
            lottie.play()
            print(currentUser.uid)

            DataManager().getDataFromUid(for: String(currentUser.uid)) { [weak self] fetchedTasks in
                self?.Tasks = fetchedTasks
                self?.table.reloadData()
                self?.lottie.stop()
                self?.lottie.isHidden = true
            }

        } else {
            print("No user was logged in")
        }
    }
    
    @objc private func handleLongPress(_ gestureRecognizer: UILongPressGestureRecognizer) {
          let location = gestureRecognizer.location(in: table)
          if gestureRecognizer.state == .began {
              if let indexPath = table.indexPathForRow(at: location) {
                  let task = Tasks[indexPath.row]
                  
                  // Show confirmation alert
                  let alert = UIAlertController(title: "Confirm Delete", message: "Are you sure you want to delete \(task.title)?", preferredStyle: .alert)
                  
                  alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                  alert.addAction(UIAlertAction(title: "Delete", style: .destructive) { _ in
                      self.deleteTask(at: indexPath)
                  })
                  
                  present(alert, animated: true, completion: nil)
              }
          }
      }
    
    private func deleteTask(at indexPath: IndexPath) {
           // Remove task from data source
           let taskID = Tasks[indexPath.row].taskID
           Tasks.remove(at: indexPath.row)
           
           // Update database
           DataManager().deleteTask(taskID: taskID) { [weak self] success in
               if !success {
                   let errorAlert = UIAlertController(title: "Error", message: "Failed to delete task. Please try again.", preferredStyle: .alert)
                   errorAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                   self?.present(errorAlert, animated: true, completion: nil)
               }
           }
       }

    
    
    private func configureLottieAnimation() {
        lottie.contentMode = .scaleAspectFit
        lottie.backgroundColor = .clear
        lottie.loopMode = .loop
        lottie.animation = LottieAnimation.named("loading2")
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

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExpandableCell", for: indexPath) as! ExpandableTableViewCell

        let task = Tasks[indexPath.row]
        let isExpanded = expandedIndexSet.contains(indexPath.row)
        
        // Use the new configure method to set up the cell
        cell.configure(with: task, at: indexPath, isExpanded: isExpanded)
        cell.delegate = self

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
    
    // ExpandableTableViewCellDelegate method
     func checkboxButton(_ button: CheckboxButton, didChangeState isChecked: Bool, at indexPath: IndexPath) {
         print("Checkbox state changed to \(isChecked) for task at \(indexPath.row)")

         // Update task based on the checkbox change
         Tasks[indexPath.row].isCompleted = isChecked

         // Update the database with the new state
         let taskID = Tasks[indexPath.row].taskID // Assuming Task has a taskID property
         DataManager().updateTaskCompletion(taskID: taskID, isChecked: isChecked)
         
         table.reloadRows(at: [indexPath], with: .none)
     }
}
