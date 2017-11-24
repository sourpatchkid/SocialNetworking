//
//  UserCell.swift
//  SocialNetworking
//
//  Created by Wyatt Allen on 11/16/17.
//  Copyright © 2017 Wyatt Allen. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {
    
    @IBOutlet weak var UserNameCell: UILabel!
    
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        UserNameCell.text = nil
    
    }
    
    func configure(someUser: String?){
        UserNameCell.text = someUser
    }
}

