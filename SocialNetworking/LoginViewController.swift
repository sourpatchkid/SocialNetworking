//
//  LoginViewController.swift
//  SocialNetworking
//
//  Created by Wyatt Allen on 11/15/17.
//  Copyright © 2017 Wyatt Allen. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let username = UserDefaults.standard.string(forKey: "username") {
            usernameTextField.text = username
        }
    }
    
    @IBAction func logInButton(_ sender: Any) {
        print(usernameTextField.text ?? "no name")
        print(passwordTextField.text ?? "no password")
        UserDefaults.standard.set(usernameTextField.text ?? "", forKey: "username")
        UserDefaults.standard.synchronize()
        let user: User? = User(name: usernameTextField.text ?? "", password: passwordTextField.text ?? "")
        self.activityIndicator.startAnimating()
        DispatchQueue.main.async {
            NetworkConnectivity.login(user: user!) 
            self.activityIndicator.stopAnimating()
            if NetworkConnectivity.messageList != nil {
                self.performSegue(withIdentifier: "LoginSegue", sender: nil)
            }
        }
    }
}


extension LoginViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("begin")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameTextField {
            passwordTextField.becomeFirstResponder()
        }
        if textField == passwordTextField && !(usernameTextField.text?.isEmpty ?? false) {
            passwordTextField.resignFirstResponder()
        }
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
    }
    
}


