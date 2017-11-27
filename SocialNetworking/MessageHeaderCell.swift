//
//  MessageHeaderCell.swift
//  SocialNetworking
//
//  Created by Wyatt Allen on 11/26/17.
//  Copyright © 2017 Wyatt Allen. All rights reserved.
//

import UIKit

class MessageHeaderCell: UITableViewCell {
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var numberLikesLabel: UILabel!
    
    func configure(username: String?, date: Date?, numberLikes: Int?) {
        usernameLabel.text = NetworkConnectivity.createHandle(someUser: username)
        dateLabel.text = NetworkConnectivity.makeNormalDateString(date: date!)
        numberLikesLabel.text = "\(numberLikes ?? 0) Likes"
    }    
}
