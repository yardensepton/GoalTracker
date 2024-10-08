//
//  DataManager.swift
//  GoalTracker-iOS
//
//  Created by Student25 on 17/08/24
//

import Foundation
import Firebase
import FirebaseDatabase

class DataManager {
    let databaseRef = Database.database().reference().child("tasks")
    
    func getDataFromUid(for userId: String, completion: @escaping ([Task]) -> Void) {


        // Query tasks where the "userID" matches the provided userId
        self.databaseRef.queryOrdered(byChild: "userID").queryEqual(toValue: userId).observe(.value) { snapshot in
            guard snapshot.exists() else {
                completion([])
                return
            }

            var tasks: [Task] = []

            for child in snapshot.children {
                if let childSnapshot = child as? DataSnapshot,
                   let taskData = childSnapshot.value as? [String: Any] {
                    // Extract task data
                    if let userID = taskData["userID"] as? String,
                       let title = taskData["title"] as? String,
                       let taskID = taskData["taskID"] as? String,
                       let description = taskData["description"] as? String,
                       let completionDate = taskData["completionDate"] as? String {

                        var task = Task(taskID: taskID, title: title, description: description, userID: userID, completionDate: completionDate)

                        if let isCompleted = taskData["isCompleted"] as? Bool {
                            task.isCompleted = isCompleted
                        }

                        // Since the query is already filtered by userID, you don't need to check it again
                        tasks.append(task)
                    }
                }
            }
            
            tasks.sort { (task1, task2) -> Bool in
                       guard let comparisonResult = task1.compare(tsk: task2) else { return false }
                       return comparisonResult == -1
                   }
          
            completion(tasks)
            
        } withCancel: { error in
            print("Error fetching data: \(error.localizedDescription)")
            completion([]) // Provide an empty array in case of an error
        }
    }
    
    func addNewTask(task: Task, completion: @escaping (Bool) -> Void) {
        self.databaseRef.child(task.taskID).setValue(task.toDictionary()) { error, _ in
            if let _ = error {
                completion(false) // Notify the caller that the operation failed
            } else {
                completion(true) // Notify the caller that the operation was successful
            }
        }
    }
    
    func updateTaskCompletion(taskID:String,isChecked:Bool){
        print(taskID)
        let taskRef = self.databaseRef.child(taskID)
        taskRef.updateChildValues(["isCompleted": isChecked])
        
    }
    
    func deleteTask(taskID: String, completion: @escaping (Bool) -> Void) {
            let taskRef = self.databaseRef.child(taskID)
            taskRef.removeValue { error, _ in
                if let _ = error {
                    completion(false) // Notify the caller that the operation failed
                } else {
                    completion(true) // Notify the caller that the operation was successful
                }
            }
        }

}
