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
        
        var task = Task(title: title!, description: desc!, userID: UserManager.shared.currentUser.uid, completionDate: date)
    }
    
    func formatDate(_ date: Date) -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            return dateFormatter.string(from: date)
        }
    
    
}
