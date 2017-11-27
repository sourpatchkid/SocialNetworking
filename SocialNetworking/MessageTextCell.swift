//
//  MessageTextCell.swift
//  SocialNetworking
//
//  Created by Wyatt Allen on 11/26/17.
//  Copyright © 2017 Wyatt Allen. All rights reserved.
//

import UIKit

class MessageTextCell: UITableViewCell {

    @IBOutlet weak var messageTextLabel: UILabel!
    
    func configure(text: String?) {
        messageTextLabel.text = text
    }
    
}
