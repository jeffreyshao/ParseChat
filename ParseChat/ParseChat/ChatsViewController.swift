//
//  ChatsViewController.swift
//  ParseChat
//
//  Created by Jeffrey Shao on 2/22/17.
//  Copyright © 2017 Jeffrey Shao. All rights reserved.
//

import UIKit
import Parse

class ChatsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var messages: [PFObject]! = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.queryMessages()
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ChatsViewController.onTimer), userInfo: nil, repeats: true)
        textField.becomeFirstResponder()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onSend(_ sender: AnyObject) {
        let message = PFObject(className:"Message")
        message["text"] = textField.text
        let coolstuff = textField.text
        message["user"] = PFUser.current()
        
        message.saveInBackground {
            (success: Bool, error: Error?) -> Void in
            if (success) {
                print(coolstuff)
                self.queryMessages()
                self.tableView.reloadData()
            } else {
                print(error?.localizedDescription)
            }
        }
    }
    
    func queryMessages(){
        let query = PFQuery(className:"Message")
        query.addDescendingOrder("createdAt")
        query.includeKey("user")
        query.findObjectsInBackground(block: { (objects: [PFObject]?, error: Error?) in
            self.messages = objects! as [PFObject]
            self.tableView.reloadData()
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if messages != nil {
            return messages!.count
        }
        else{
            return 0
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let message = messages[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell") as! MessageCell
        cell.message.text = message["text"] as! String!
        if let user = message["user"] as? PFUser    {
            cell.triggerUser(user: user)
        }   else    {
            cell.hideUser()
        }
        return cell
    }
    
    func onTimer()  {
        tableView.reloadData()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
