//
//  MessagesViewController.swift
//  SocialNetworking
//
//  Created by Wyatt Allen on 11/15/17.
//  Copyright © 2017 Wyatt Allen. All rights reserved.
//

import UIKit

class MessagesViewController: UIViewController {
    
    @IBOutlet weak var messagesView: UITableView!
    
    @IBOutlet weak var sendMessageButton: UIButton!
    
    
    
    var isDirectMessage: Bool = false

    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if sendMessageButton == (sender as? UIButton) {
            if isDirectMessage == false {

                guard let destination = segue.destination as? SendMessageViewController else {return}
                destination.to = nil
                destination.from = nil
                destination.message = nil
                destination.replyToID = nil
                
            }
            else if isDirectMessage == true {
                guard segue.destination is UsersViewController else {return}
            }
        }
            
        else {
            guard let destination = segue.destination as? ViewMessageViewController else {return}
            guard let source = sender as? MessageCell else { return }
            destination.to = source.to
            destination.from = source.from
            destination.message = source.message
        }
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.navigationController?.tabBarItem.title == "Messages" {
            isDirectMessage = false
        } else {isDirectMessage = true}
        
        print("Messages: \(isDirectMessage)" )
        
        messagesView.dataSource = self
    }

}

extension MessagesViewController: UITableViewDataSource {
    
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if isDirectMessage == false {
            return (NetworkConnectivity.messageList?.messages.count)!

        }
        else if isDirectMessage == true {
            return (NetworkConnectivity.directMessageList?.directMessages.count)!

        }
        else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath) as! MessageCell
        if isDirectMessage == false {
            cell.configure(
                to: nil,
                from: nil,
                message: NetworkConnectivity.messageList?.messages[indexPath.item])
            return cell
        }
        else if isDirectMessage == true {
            cell.configure(
                to: NetworkConnectivity.directMessageList?.directMessages[indexPath.item].to,
                from: NetworkConnectivity.directMessageList?.directMessages[indexPath.item].from,
                message: NetworkConnectivity.directMessageList?.directMessages[indexPath.item].message)
            return cell
        }
        else {
            cell.configure(to: nil, from: nil, message: nil)
            return cell
        }
    }
}
