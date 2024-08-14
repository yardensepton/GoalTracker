import UIKit
import FirebaseAuth

class LoginController: UIViewController {
    
    @IBOutlet weak var email_et: UITextField!
    @IBOutlet weak var password_et: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        guard let email = email_et.text, !email.isEmpty,
              let password = password_et.text, !password.isEmpty else {
            self.showToast(message: "Email or password fields can not be empty")
            return
        }
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                self.showToast(message: "Failed to log in: \(error.localizedDescription)")
            } else {
                self.showToast(message: "User \(authResult?.user.email ?? "") has signed in")
                self.goToMainController()
            }
        }
    }
    
    func goToMainController(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let mainController = storyboard.instantiateViewController(withIdentifier: "MainController") as? MainController {
            mainController.currentUser = Auth.auth().currentUser
            
            self.navigationController?.pushViewController(mainController, animated: true)
        }
    }
}

