//
//  TaskModel.swift
//  TodoMemo
//
//  Created by picomax on 2016. 6. 23..
//  Copyright © 2016년 picomax. All rights reserved.
//

import UIKit

class TaskModel: NSObject {
    var title: String
    var memo: String
    var done: Bool = false
    
    init(title: String, memo: String, done: Bool = false) {
        self.title = title
        self.memo = memo
        self.done = done
    }
}
