import Foundation
import Firebase
import FirebaseDatabase

class DataManager {
    
    func getDataFromUid(for userId: String, completion: @escaping ([Task]) -> Void) {
        let databaseRef = Database.database().reference().child("tasks")
        
        databaseRef.observeSingleEvent(of: .value) { snapshot in
            print("Snapshot exists: \(snapshot.exists())")

            guard snapshot.exists() else {
                print("No data found at the path")
                completion([])
                return
            }

            var tasks: [Task] = []
            
            for child in snapshot.children {
                if let childSnapshot = child as? DataSnapshot {
                    print("Child key: \(childSnapshot.key)")
                    print("Child value: \(childSnapshot.value ?? "nil")")
                    
                    if let taskData = childSnapshot.value as? [String: Any] {
                        // Handle task data here as before
                        if let userID = taskData["userID"] as? String,
                           let title = taskData["title"] as? String,
                           let description = taskData["description"] as? String,
                           let completionDate = taskData["completionDate"] as? String {
                            
                            var task = Task(title: title, description: description, userID: userID, completionDate: completionDate)
                            
                            if let isCompleted = taskData["isCompleted"] as? Bool {
                                task.isCompleted = isCompleted
                            }
                            
                            if userID == userId {
                                tasks.append(task)
                            }
                        }
                    }
                }
            }
            
            completion(tasks)
        }
    }
}
