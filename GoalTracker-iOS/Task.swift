import Foundation

class Task {
    let title: String
    let description: String
    let userID: String
    let completionDate: String
    let isCompleted: Bool
    
    init(title: String, description: String, userID: String, completionDate: String) {
        self.title = title
        self.description = description
        self.userID = userID
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
}
