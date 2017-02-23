//
//  MessageCell.swift
//  ParseChat
//
//  Created by Jeffrey Shao on 2/22/17.
//  Copyright © 2017 Jeffrey Shao. All rights reserved.
//

import UIKit
import Parse

class MessageCell: UITableViewCell {
    
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var message: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        message.sizeToFit()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func triggerUser(user: PFUser)  {
        if let name = user.username {
            username.text = name
            stackView.arrangedSubviews[0].isHidden = false
        }   else    {
            //hideUser()
        }
    }
    
    func hideUser() {
        stackView.arrangedSubviews[0].isHidden = true
    }
    
    

}
