import UIKit

class NewTaskControllerViewController: UIViewController {

    @IBOutlet weak var title_et: UITextField!
    
    @IBOutlet weak var desc_et: UITextField!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var addBTN: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
    @IBAction func addTaskPressed(_ sender: UIButton) {
        let title = title_et.text
        let desc = desc_et.text
        let date = formatDate(datePicker.date)
        let uid : String? = UserManager.shared.currentUser?.uid
        let taskID : String = NSUUID().uuidString
        
        var task = Task(taskID:taskID,title: title!, description: desc!, userID:uid!, completionDate: date)
        DataManager().self.addNewTask(task: task) { success in
            if success {
                self.showToast(message: "Task added")
                self.navigationController?.popViewController(animated: true)
            } else {
                self.showToast(message: "Error")
            }
        }
       
   
    }
    
    func formatDate(_ date: Date) -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            return dateFormatter.string(from: date)
        }
    
    
}
