import UIKit
import FirebaseAuth

class MainController: UIViewController {
    
    @IBOutlet weak var emailText: UILabel!
    
    var currentUser: User?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        
        if let user = currentUser {
            emailText.text = user.email
        }
    }
}
