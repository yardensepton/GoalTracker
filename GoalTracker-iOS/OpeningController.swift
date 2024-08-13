import UIKit

class OpeningController: UIViewController {
    
    
    @IBOutlet weak var LoginBTN: UIButton!
    @IBOutlet weak var SignupBTN: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }


    @IBAction func loginPressed(_ sender: UIButton) {
        let storyboard = self.storyboard?.instantiateViewController(withIdentifier: "LoginController") as! LoginController
        self.navigationController?.pushViewController(storyboard, animated: true)
    }
    
    
    @IBAction func signupPressed(_ sender: UIButton) {
        let storyboard = self.storyboard?.instantiateViewController(withIdentifier: "SignUpController") as! SignupController
        self.navigationController?.pushViewController(storyboard, animated: true)
    }
    
}

