//
//  OpeningController.swift
//  GoalTracker-iOS
//
//  Created by Student5 on 13/08/24
//

import UIKit

class OpeningController: UIViewController {
    
    
    @IBOutlet weak var LoginBTN: UIButton!
    @IBOutlet weak var SignupBTN: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UserManager.shared.currentUser != nil{
            goToMainController()
        }
                
            
      
    }
    
    func goToMainController(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let mainController = storyboard.instantiateViewController(withIdentifier: "MainController") as? MainController {
            self.navigationController?.pushViewController(mainController, animated: true)
        }
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
