//
//  UsersViewController.swift
//  SocialNetworking
//
//  Created by Wyatt Allen on 11/15/17.
//  Copyright © 2017 Wyatt Allen. All rights reserved.
//

import UIKit

class UsersViewController: UIViewController {
    
    @IBOutlet weak var userView: UITableView!
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        userView.dataSource = self
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? SendMessageViewController else {return}
        guard let source = sender as? UserCell else { return }
        destination.to = source.someUser
        destination.replyToID = nil
    }
    
}

extension UsersViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (NetworkConnectivity.userList?.users.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as! UserCell
        cell.configure(someUser: NetworkConnectivity.userList?.users[indexPath.item])
        return cell
    }
}

