//
//  Str.swift
//  TodoApp
//
//  Created by Afees Lawal on 04/08/2020.
//

import Foundation

struct Str {
    //Common
    struct Common {
        static let category: String = "Category"
    }

    // App
    struct App {
        // Onboarding
        struct Onboarding {
            static let title: String = "Reminders made simple"
            static let subtitle: String = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris pellentesque erat in blandit luctus."
            static let getStarted: String = "Get Started"
        }
    }

    // Main App
    struct Main {
        // Home
        struct Home {
            // EmptyTask
            struct EmptyTask {
                static let noTasks: String = "No tasks"
                static let noTasksTodo: String = "You have no task to do."
            }
            // Header
            struct Header {
                static func headerWithTaskCount(taskCount: Int) -> String {
                    return taskCount == 0 ? "Today you have no tasks" : "Today you have \(taskCount) tasks"
                }
            }
        }

        // Home
        struct NewTask {
            static let taskTitle: String = "Task title"
            static let noteDescription: String = "Task description here"
            static let createTask: String = "Create Task"
            static let timeDate: String = "Time & Date"
            static let taskTitleEmpty: String = "Task title cannot be empty!"
            static let taskNoteEmpty: String = "Write a short note about the task"
            static let lateDateSelected: String = "Please select a future date"
        }

        // Categories
        struct Categories {
            static func tasksCount(_ count: Int) -> String {
                return count <= 1 ? "\(count) Task" : "\(count) tasks"
            }
        }
    }
}
