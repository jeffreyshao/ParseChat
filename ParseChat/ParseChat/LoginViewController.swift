//
//  ViewController.swift
//  ParseChat
//
//  Created by Jeffrey Shao on 2/22/17.
//  Copyright © 2017 Jeffrey Shao. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onSignup(_ sender: AnyObject) {
        let user = PFUser()
        user.username = emailText.text
        user.email = emailText.text
        user.password = passwordText.text
        
        user.signUpInBackground(block: { (succeeded: Bool, error: Error?) -> Void in
            if let error = error {
                print(error.localizedDescription)
                self.displayWarning(message: "Signup Failed")
                
            } else {
                // Hooray! Let them use the app now.
                
                self.performSegue(withIdentifier: "ChatControllerSegue", sender: self)
            }
        })
        
    }
    
    @IBAction func onLogin(_ sender: AnyObject) {
        PFUser.logInWithUsername(inBackground: emailText.text!, password: passwordText.text!) { (user: PFUser?, error: Error?) in
            if(user != nil)  {
                print("Yoooo")
                self.performSegue(withIdentifier: "ChatControllerSegue", sender: self)
            }   else    {
                print(error?.localizedDescription as Any)
                self.displayWarning(message: "Login failed")
            }
        }
    }
    
    func displayWarning(message: String?)   {
        let alertController = UIAlertController(title: "Boo, not cool", message: message, preferredStyle: .alert)
        // create an OK action
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
            // handle response here.
        }
        // add the OK action to the alert controller
        alertController.addAction(OKAction)
        
        present(alertController, animated: true) {
            // optional code for what happens after the alert controller has finished presenting
        }
    }
    
    
}

