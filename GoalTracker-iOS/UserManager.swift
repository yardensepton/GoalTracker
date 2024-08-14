import Foundation
import FirebaseAuth

class UserManager {
    static let shared = UserManager()

    private init() {
        // Private initialization to ensure just one instance is created.
    }

    var currentUser: User? {
        return Auth.auth().currentUser
    }

    func getCurrentUser() -> User? {
        return currentUser
    }
}
