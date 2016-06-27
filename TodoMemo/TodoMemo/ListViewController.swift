//
//  ListViewController.swift
//  TodoMemo
//
//  Created by picomax on 2016. 6. 23..
//  Copyright © 2016년 picomax. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {

    @IBOutlet weak var editButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    var taskListManager: TaskListManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        taskListManager = TaskListManager.sharedInstance
        //tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier:"todoCell")
    }
    
    override func viewWillAppear(animated: Bool) {
        taskListManager.loadAll()
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func editButtonDidTap() {
        guard !taskListManager.taskModelArray.isEmpty else {
            return
        }
        
        //button.addTarget(self, action: #selector(buttonAction), forControlEvents: .TouchUpInside)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: #selector(doneButtonTapped))
        self.navigationItem.leftBarButtonItem = doneButton
        self.tableView.setEditing(true, animated: true)
    }
    
    func doneButtonTapped() {
        let editButton = UIBarButtonItem(barButtonSystemItem: .Edit, target: self, action: #selector(editButtonDidTap))
        self.navigationItem.leftBarButtonItem = editButton
        self.tableView.setEditing(false, animated: true)
    }
}


// MARK: - UITableViewDataSource

extension ListViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskListManager.taskModelArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("todoCell")!
        //let cell = tableView.dequeueReusableCellWithIdentifier("BookCell") as BookTableViewCell
        
        let taskModel = taskListManager.taskModelArray[indexPath.row]
        cell.textLabel?.text = taskModel.title
        cell.detailTextLabel?.text = taskModel.memo
        
        if taskModel.done {
            cell.accessoryType = .Checkmark
        } else {
            cell.accessoryType = .None
        }
        
        return cell
    }
    
}


// MARK: - UITableViewDelegate

extension ListViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let taskModel = taskListManager.taskModelArray[indexPath.row]
        taskModel.done = !taskModel.done
        self.taskListManager.taskModelArray[indexPath.row] = taskModel
        self.tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)

    }
    
    func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }

    func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        let taskModel = taskListManager.taskModelArray[sourceIndexPath.row]
        taskListManager.taskModelArray.removeAtIndex(sourceIndexPath.row)
        taskListManager.taskModelArray.insert(taskModel, atIndex: destinationIndexPath.row)
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        tableView.beginUpdates()
        taskListManager.taskModelArray.removeAtIndex(indexPath.row)
        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        tableView.endUpdates()
        
        if taskListManager.taskModelArray.isEmpty {
            self.doneButtonTapped()
        }
    }
    
}
