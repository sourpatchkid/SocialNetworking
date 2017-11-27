//
//  MessageCell.swift
//  SocialNetworking
//
//  Created by Wyatt Allen on 11/15/17.
//  Copyright © 2017 Wyatt Allen. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {
    
    @IBOutlet weak var MessageTextLabel: UILabel!
    @IBOutlet weak var MessageUserLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var numberLikesLabel: UILabel!
    @IBOutlet weak var isImgURL: UILabel!
    @IBOutlet weak var numberRepliesLabel: UILabel!
    
    var to: String?
    var from: String?
    var message: Message?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        MessageTextLabel.text = nil
        MessageUserLabel.text = nil
        dateLabel.text = nil
        numberLikesLabel.text = nil
        isImgURL.text = nil
    }
    
    func configure(to: String?, from: String?, message: Message?){
        self.message = message
        MessageUserLabel.text = NetworkConnectivity.createHandle(someUser: message?.user )
        MessageTextLabel.text = message?.text
        dateLabel.text = NetworkConnectivity.makeNormalDateString(date: message?.date)
        if message?.likedBy != nil {
            numberLikesLabel.text = "\((message?.likedBy?.count)!) Likes"
        } else { numberLikesLabel.text = nil }
        isImgURL.text = nil
        var mc: Int? = (NetworkConnectivity.createMessageReplyList(message: message)?.messages.count)!
        if mc == nil  {
            mc = 0
        }
        numberRepliesLabel.text = "\(mc!) Replies"
        
    }
}

