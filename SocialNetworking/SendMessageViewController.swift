//
//  SendMessageViewController.swift
//  SocialNetworking
//
//  Created by Wyatt Allen on 11/15/17.
//  Copyright © 2017 Wyatt Allen. All rights reserved.
//

import UIKit

class SendMessageViewController: UIViewController {
   
    @IBOutlet weak var TextView: UITextView!
    
    @IBOutlet weak var navigationHeader: UINavigationItem!

    @IBOutlet weak var toLabel: UILabel!
    
    @IBOutlet weak var toSomeUserLabel: UILabel!
    
    @IBOutlet weak var messageLabel: UILabel!
    
    var to: String?
    var from: String?
    var message: Message?
    
    var imgURL: URL?
    var replyToID: String?
    

    @IBAction func sendMessageButton(_ sender: Any) {
        let uuid = UUID()
        let newMessage = Message(user: UserDefaults.standard.value(forKey: "username") as? String, text: TextView.text, date: Date(), imgURL: imgURL, id: uuid.uuidString, replyTo: replyToID, likedBy: [])
        NetworkConnectivity.sendNewMessage(to: to, from: from, message: newMessage)
      
    }
    
}
