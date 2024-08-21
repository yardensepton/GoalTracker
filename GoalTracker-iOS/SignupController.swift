//
//  SignupCotroller.swift
//  GoalTracker-iOS
//
//  Created by Student5 on 13/08/24
//

import UIKit
import FirebaseAuth

class SignupController: UIViewController {
    
    @IBOutlet weak var name_et: UITextField!
    @IBOutlet weak var email_et: UITextField!
    @IBOutlet weak var password_et: UITextField!
    
    @IBOutlet weak var createBTN: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func signUpPressed(_ sender: UIButton) {
        guard let email = email_et.text, !email.isEmpty,
              let password = password_et.text, !password.isEmpty
                else {
                    self.showToast(message:"Missing name, email or password")
                    return
                }
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                self.showToast(message: "Error signing up: \(error.localizedDescription)")
            } else {
                self.navigationController?.popViewController(animated: true)
                self.showToast(message: "Signed up successfully, now login")
            }
        }
    }
}
