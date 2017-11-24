//
//  NetworkConnectivity.swift
//  SocialNetwork
//
//  Created by Wyatt Allen on 11/14/17.
//  Copyright © 2017 Wyatt Allen. All rights reserved.
//

import Foundation

class NetworkConnectivity{
    
    let userListUrl = URL(string: "https://obscure-crag-65480.herokuapp.com/users")!
    let messagesURL = URL(string: "https://obscure-crag-65480.herokuapp.com/messages")!
    let directUrl = URL(string: "https://obscure-crag-65480.herokuapp.com/direct")!
    let likeUrl = URL(string: "https://obscure-crag-65480.herokuapp.com/like")!
    
    let user: User? = nil
    var loginToken: Token? = nil
    static var userList: usersList?
    var message: Message? = nil
    
    
    static func login(user: User) {
        let loginUrl = URL(string: "https://obscure-crag-65480.herokuapp.com/login")!
        var loginRequest = URLRequest(url: loginUrl)
        loginRequest.httpBody = try? JSONEncoder().encode(user)
        loginRequest.httpMethod = "POST"
        let loginTask = URLSession(configuration: .ephemeral).dataTask(with: loginRequest) { (data, response, error) in
            //            self.loginToken = try? JSONDecoder().decode(Token.self, from: data!)
            let loginToken = try? JSONDecoder().decode(Token.self, from: data!)
            UserDefaults.standard.set((loginToken?.token)!, forKey: "token")
            UserDefaults.standard.synchronize()
            getUserList()
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
            print(usersList!)
            userList?.users = usersList!
            print("network connectivity, userList?.users:")
            print(userList?.users)
        }
        getUsersTask.resume()
    }
    
    func getMessages() {
        var messagesRequest = URLRequest(url: messagesURL)
        messagesRequest.httpMethod = "GET"
        messagesRequest.addValue((loginToken?.token)!, forHTTPHeaderField: "token")
        let messageListTask = URLSession(configuration: .ephemeral).dataTask(with: messagesRequest)
        { (data, response, error) in
            let messages = try? JSONDecoder().decode([Message].self, from: data!)
        }
        messageListTask.resume()
    }
    
    func sendMessage(message: String) {
        var messagesRequest = URLRequest(url: messagesURL)
        messagesRequest.httpMethod = "POST"
    }
    
    
    func sendDirectMessage(directMessage: String, user: String) {
        var directRequest = URLRequest(url: directUrl)
        directRequest.httpMethod = "POST"
    }
    
    func likeMessage() {
        var likeRequest = URLRequest(url: likeUrl)
        likeRequest.httpMethod = "POST"
    }
    
    
}

