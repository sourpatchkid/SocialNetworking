//
//  NetworkConnectivity.swift
//  SocialNetwork
//
//  Created by Wyatt Allen on 11/14/17.
//  Copyright © 2017 Wyatt Allen. All rights reserved.
//

import Foundation
import UIKit

class NetworkConnectivity{
    
    static let loginUrl = URL(string: "https://obscure-crag-65480.herokuapp.com/login")!
    static let userListUrl = URL(string: "https://obscure-crag-65480.herokuapp.com/users")!
    static let messagesURL = URL(string: "https://obscure-crag-65480.herokuapp.com/messages")!
    static let directUrl = URL(string: "https://obscure-crag-65480.herokuapp.com/direct")!
    static let likeUrl = URL(string: "https://obscure-crag-65480.herokuapp.com/like")!
    static let likeURL = URL(string: "https://obscure-crag-65480.herokuapp.com/like")!

    
    let user: User? = nil
    var loginToken: Token? = nil
    static var userList: UsersList?
    static var message: Message?
    static var messageList: MessageList?
    static var directMessage: DirectMessage?
    static var directMessageList: DirectMessageList?
    
    
    
    static func login(user: User){
        var loginRequest = URLRequest(url: loginUrl)
        loginRequest.httpBody = try? JSONEncoder().encode(user)
        loginRequest.httpMethod = "POST"
        let loginTask = URLSession(configuration: .ephemeral).dataTask(with: loginRequest) { (data, response, error) in
            let loginToken = try? JSONDecoder().decode(Token.self, from: data!)
            UserDefaults.standard.set((loginToken?.token)!, forKey: "token")
            UserDefaults.standard.synchronize()
            DispatchQueue.main.async {
                getMessages()
                getDirectMessages()
                getUserList()
            }
        }
        loginTask.resume()
    }
    
    static func getUserList(){
        print(UserDefaults.standard.value(forKey: "token") as! String)
        let userListUrl = URL(string: "https://obscure-crag-65480.herokuapp.com/users")!
        var userListRequest = URLRequest(url: userListUrl)
        userListRequest.httpMethod = "GET"
        userListRequest.addValue(UserDefaults.standard.value(forKey: "token") as! String, forHTTPHeaderField: "token")
        print(userListRequest.value(forHTTPHeaderField: "token"))
        let getUsersTask = URLSession(configuration: .ephemeral).dataTask(with: userListRequest) { (data, response, error) in
            let usersList: [String]? = try? JSONDecoder().decode([String].self, from: data!)
            userList = UsersList(users: usersList!)
            
        }
        getUsersTask.resume()
    }
    
    static func getMessages() {
        var messagesRequest = URLRequest(url: messagesURL)
        messagesRequest.httpMethod = "GET"
        messagesRequest.addValue(UserDefaults.standard.value(forKey: "token") as! String, forHTTPHeaderField: "token")
        let messageListTask = URLSession(configuration: .ephemeral).dataTask(with: messagesRequest)
        { (data, response, error) in
            let messages = try? JSONDecoder().decode([Message].self, from: data!)
            messageList = MessageList(messages: messages!)
        }
        messageListTask.resume()
    }
    
    static func sendMessage(message: Message) {
        var messagesRequest = URLRequest(url: messagesURL)
        messagesRequest.httpMethod = "POST"
        messagesRequest.addValue(UserDefaults.standard.value(forKey: "token") as! String, forHTTPHeaderField: "token")
        
    
        messagesRequest.httpBody = try? JSONEncoder().encode(message)
        
        let sendMessageTask = URLSession(configuration: .ephemeral).dataTask(with: messagesRequest) { (data, response, error) in
            let returnSuccess = try? JSONDecoder().decode([String].self, from: data!)
            print(returnSuccess as [String]!)
        }
        sendMessageTask.resume()
    }
    
    static func getDirectMessages() {
        var directMessageRequest = URLRequest(url: directUrl)
        directMessageRequest.httpMethod = "GET"
        directMessageRequest.addValue(UserDefaults.standard.value(forKey: "token") as! String, forHTTPHeaderField: "token")
        let directMessageListTask = URLSession(configuration: .ephemeral).dataTask(with: directMessageRequest) { (data, response, error) in
            let directMessages = try? JSONDecoder().decode([DirectMessage].self, from: data!)
            directMessageList = DirectMessageList(directMessages: directMessages!)
        }
        directMessageListTask.resume()
    }
    
    
    static func sendDirectMessage(directMessage: DirectMessage) {
        var directMessageRequest = URLRequest(url: directUrl)
        directMessageRequest.httpMethod = "POST"
        directMessageRequest.httpBody = try? JSONEncoder().encode(directMessage)        
        let sendDirectMessageTask = URLSession(configuration: .ephemeral).dataTask(with: directMessageRequest) { (data, response, error) in
            let directMessageSuccess = try? JSONDecoder().decode([String].self, from: data!)
            print(directMessageSuccess)
        }
        sendDirectMessageTask.resume()
        
    }
    
    static func sendNewMessage (to: String?, from: String?, message: Message?) {
        
        if to == nil && from == nil && message != nil{
            sendMessage(message: message!)
        }
        else if to != nil && from != nil && message != nil{
            let directMessage = DirectMessage(to: to, from: from, message: message)
            sendDirectMessage(directMessage: directMessage)
        }
        
    }
    
    
    
    
    static func likeMessage() {
        var likeRequest = URLRequest(url: likeUrl)
        likeRequest.httpMethod = "POST"
    }
    
    
    static func imageForURL(url: URL?, completion: @escaping (UIImage?, URL?) -> ()) {
        
        guard let url = url else { completion(nil, nil); return}
        let task = URLSession(configuration: .ephemeral).dataTask(with: url) {
            (data, response, error) in
            
            guard data != nil else { completion (nil, nil); return}
            if error != nil {completion(nil, nil); return}
            let image = UIImage(data: data!)
            DispatchQueue.main.async {
                completion(image, url)
            }
        }
        task.resume()
    }
    
    
    static func createRealName(someUser: String) -> String{
        var realName = someUser.replacingOccurrences(of: "." , with: " ")
        realName = realName.capitalized
        return realName
    }
    
    static func createHandle(someUser: String?) -> String?{
        var someUserHandle: String? = someUser
        if someUserHandle != nil {
            someUserHandle!.insert("@", at: someUserHandle!.startIndex)
            return someUserHandle!
        }
        else { return nil }
    }
    
    static func makeNormalDateString(date: Date?) -> String? {
        if date != nil {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM-dd-yyy"
            return dateFormatter.string(from: date!)
        }
        else { return nil }
        
    }
    
    static func createMessageReplyList(message: Message?) -> MessageList? {
        var r: MessageList? = MessageList(messages: [])
        for d: DirectMessage in (NetworkConnectivity.directMessageList?.directMessages)! {
            if message?.id == d.message?.replyTo && message?.id != nil {
                r?.messages.append(d.message!)
            }
        }
        for m: Message in (NetworkConnectivity.messageList?.messages)! {
            if message?.id == m.replyTo && message?.id != nil {
                r?.messages.append(m)
            }
        }
        return r
    }
    
    static func likeMessage(id: String?) {
        var likeRequest = URLRequest(url: likeURL)
        likeRequest.addValue(UserDefaults.standard.value(forKey: "token") as! String, forHTTPHeaderField: "token")
        likeRequest.httpMethod = "POST"
        let likedMessage = try? JSONEncoder().encode(id)
        likeRequest.httpBody = likedMessage
        URLSession(configuration: .ephemeral).dataTask(with: likeRequest)
    }
    
    
    
}
