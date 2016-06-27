//
//  TaskListManager.swift
//  TodoMemo
//
//  Created by picomax on 2016. 6. 23..
//  Copyright © 2016년 picomax. All rights reserved.
//

import UIKit

let TodoListkUserDefaultsKey = "TodoListkUserDefaultsKey"

private let sharedTaskListManager = TaskListManager()

class TaskListManager {
    private init() {
        print("haha1111")
        self.loadAll()
    }
    
    class var sharedInstance: TaskListManager {
        print("haha0000")
        return sharedTaskListManager
    }
    
    var taskModelArray = [TaskModel]() {
        didSet {
            self.saveAll()
        }
    }
    
    func saveAll() {
        let data = self.taskModelArray.map {
            [
                "title": $0.title,
                "memo": $0.memo,
                "done": $0.done,
            ]
        }
        
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setObject(data, forKey: TodoListkUserDefaultsKey)
        userDefaults.synchronize()
    }
    
    func loadAll() {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        guard let data = userDefaults.objectForKey(TodoListkUserDefaultsKey) as? [[String: AnyObject]] else {
            return
        }
        
        self.taskModelArray = data.flatMap {
            guard let title = $0["title"] as? String else {
                return nil
            }
            
            guard let memo = $0["memo"] as? String else {
                return nil
            }
            
            let done = $0["done"]?.boolValue == true
            return TaskModel(title: title, memo: memo, done: done)
        }
    }
}