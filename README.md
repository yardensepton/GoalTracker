# Goal Tracker

## About
Goal Tracker is a simple iOS application that helps users manage and track their tasks. It connects to a Firebase database to read tasks specific to each user and offers functionalities to add, complete, and delete tasks.

## Features
- **Task Management**: Add, complete, and delete tasks.
- **Firebase Integration**: Syncs tasks with Firebase, ensuring that data is consistently up-to-date across sessions.
- **Expandable Task View**: Allows users to view detailed task information with an expandable/collapsible cell interface.

## Usage

`MainController` is the primary view controller that handles the display and interaction of tasks.
- **Tasks Table**: Displays a list of tasks for the logged-in user.
- **New Task Button**: Navigates to the task creation screen.
- **Expandable Cells**: Each task can be expanded to show more details.
- **Task Deletion**: Long press on a task to delete it after confirmation.
- **Task Completion**: Mark tasks as completed directly from the task list.

## Technologies
- Firebase Database and Authentication
- Swift
- UIKit

## Demo
https://github.com/user-attachments/assets/76fe722a-62e2-4335-ba44-67c2f97a41b1

