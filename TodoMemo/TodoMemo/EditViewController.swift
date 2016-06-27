//
//  EditViewController.swift
//  TodoMemo
//
//  Created by picomax on 2016. 6. 23..
//  Copyright © 2016년 picomax. All rights reserved.
//

import UIKit

class EditViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var memoTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        titleTextField.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func listButtonTapped(sender: AnyObject) {
        NSLog("list");
        
        if titleTextField.text?.isEmpty == true && memoTextField.text?.isEmpty == true {
            self.navigationController?.popViewControllerAnimated(true)
            return
        }
 
        let yes = UIAlertAction(title: "작성취소", style: .Destructive) { _ in
            self.navigationController?.popViewControllerAnimated(true)
        }
        let no = UIAlertAction(title: "작성계속", style: .Default) { _ in
            self.titleTextField.becomeFirstResponder()
        }
        
        let alertController = UIAlertController(
            title: "작성중인 내용이 있습니다",
            message: "작성중인 내용이 손실됩니다.",
            preferredStyle: .Alert
        )
        alertController.addAction(yes)
        alertController.addAction(no)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    @IBAction func doneButtonTapped(sender: AnyObject) {
        NSLog("done");
        
        guard let title = self.titleTextField.text where !title.isEmpty else {
            self.shkeTitleTextField()
            return
        }
        
        self.titleTextField.resignFirstResponder()
        
        let newTask = TaskModel(title: title, memo: self.memoTextField.text!)
        TaskListManager.sharedInstance.taskModelArray.append(newTask)
        
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func goList() {
        print("go Back!!")
        // self.navigationController?.popViewControllerAnimated(true)
    }
    
    
    func shkeTitleTextField() {
        UIView.animateWithDuration(0.05, animations: { self.titleTextField.frame.origin.x -= 5 }) { _ in
            UIView.animateWithDuration(0.05, animations: { self.titleTextField.frame.origin.x += 10 }) { _ in
                UIView.animateWithDuration(0.05, animations: { self.titleTextField.frame.origin.x -= 10 }) { _ in
                    UIView.animateWithDuration(0.05, animations: { self.titleTextField.frame.origin.x += 10 }) { _ in
                        UIView.animateWithDuration(0.05) { self.titleTextField.frame.origin.x -= 5 }
                    }
                }
            }
        }
    }
    
}
