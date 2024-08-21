//
//  Task.swift
//  GoalTracker-iOS
//
//  Created by Student5 on 13/08/24
//

import Foundation

class Task {
    let title: String
    let taskID : String
    let description: String
    let userID: String
    let completionDate: String
    var isCompleted: Bool
    
    init(taskID : String,title: String, description: String, userID: String, completionDate: String) {
        self.title = title
        self.description = description
        self.userID = userID
        self.taskID = taskID
        self.completionDate = completionDate
        self.isCompleted = false
    }
    
    func compare (tsk: Task) -> Int? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        guard let date1 = dateFormatter.date(from: self.completionDate),
              let date2 = dateFormatter.date(from: tsk.completionDate) else {
                print("Invalid date format.")
                return nil
        }
        if date1 < date2 {
            return -1
        } else if date1 > date2 {
            return 1
        } else {
            return 0
        }
    }
    
    func toDictionary() -> [String: Any] {
            return [
                "title": title,
                "isCompleted": isCompleted,
                "description" : description,
                "userID": userID,
                "taskID" : taskID,
                "completionDate" : completionDate
            ]
        }
}
