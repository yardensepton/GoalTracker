import Foundation
import FirebaseAuth

class UserManager {
    static let shared = UserManager()
    
    private init() {
//        listenToAuthStateChanges()
    }
    
    var currentUser: User? {
        return Auth.auth().currentUser
    }
 
    
    func signOutUser() -> Bool{
        do {
            try Auth.auth().signOut()
            // Navigate to the login screen or update the UI as needed
            return true
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
            // Handle the error (e.g., show an alert)
            return false
        }
    }
    private func listenToAuthStateChanges() {
        Auth.auth().addStateDidChangeListener { [weak self] auth, user in
            guard let self = self else { return }
            
            if let user = user {
                print("User signed in: \(user.uid)")
                
            } else {
                print("User signed out")
                
            }
        }
    }
}
