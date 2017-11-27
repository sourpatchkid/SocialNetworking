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
    @IBOutlet weak var RealNameCell: UILabel!
    
    var someUser: String?
    
  
    override func prepareForReuse() {
        super.prepareForReuse()
        UserNameCell.text = nil
    }
    
    func configure(someUser: String?){
        
        UserNameCell.text = NetworkConnectivity.createHandle(someUser: someUser!)
        RealNameCell.text = NetworkConnectivity.createRealName(someUser: someUser!)
        self.someUser = someUser
    }
    
   
    
}

