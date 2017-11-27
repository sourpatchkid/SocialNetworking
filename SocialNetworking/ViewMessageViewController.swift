//
//  ViewMessageViewController.swift
//  SocialNetworking
//
//  Created by Wyatt Allen on 11/26/17.
//  Copyright © 2017 Wyatt Allen. All rights reserved.
//

import UIKit

class ViewMessageViewController: UIViewController {

    
    @IBOutlet weak var viewMessagesView: UITableView!
    
    @IBAction func likeButton(_ sender: Any) {
        
        NetworkConnectivity.likeMessage(id: message?.id)
        
    }

    @IBOutlet weak var replyButton: UIButton!
    
    
    var to: String?
    var from: String?
    var message: Message?
    var isDirectMessage: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if to == nil && from == nil && message != nil {
            isDirectMessage = false
        }
        else if to != nil && from != nil && message != nil {
            isDirectMessage = true
        }
     viewMessagesView.dataSource = self
        
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if replyButton == (sender as? UIButton){
            guard let destination = segue.destination as? SendMessageViewController else {return}
            guard let source = sender as? MessageCell else { return }
            destination.to = source.to
            destination.from = source.from
            destination.message = source.message
            destination.replyToID = source.message?.id
        }
        else{
        guard let destination = segue.destination as? ViewMessageViewController else {return}
        guard let source = sender as? MessageCell else { return }
        destination.to = source.to
        destination.from = source.from
        destination.message = source.message
        }

    }
    
    
}

extension ViewMessageViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        case 2:
            return 1
        case 3:
            return (NetworkConnectivity.createMessageReplyList(message: message)?.messages.count)!
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "MessageHeaderCell", for: indexPath) as! MessageHeaderCell
            cell.configure(username: message?.user, date: message?.date, numberLikes:  message?.likedBy?.count)
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "MessageTextCell", for: indexPath) as! MessageTextCell
            cell.configure(text: message?.text)
            return cell
            
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ImageCell", for: indexPath) as! ImageCell
            cell.configure(imgURL: message?.imgURL)
            return cell
            
        case 3: fallthrough
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "MessageReplyCell", for: indexPath) as! MessageCell
            if isDirectMessage == false{
                cell.configure(
                    to: nil,
                    from: nil,
                    message: NetworkConnectivity.createMessageReplyList(message: message)?.messages[indexPath.item])
                return cell
            } else {
                cell.configure(
                    to: nil,
                    from: nil,
                    message: NetworkConnectivity.createMessageReplyList(message: message)?.messages[indexPath.item])
                return cell
            
            }
        }
    }
}

