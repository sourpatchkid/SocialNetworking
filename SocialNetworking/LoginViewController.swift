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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let username = UserDefaults.standard.string(forKey: "username") {
            usernameTextField.text = username
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "LoginSegue" {
            let TabBarViewController = segue.destination
            TabBarViewController.title = "Home"
        }
    }
    
    @IBAction func logInButton(_ sender: Any) {
        print(usernameTextField.text ?? "no name")
        print(passwordTextField.text ?? "no password")
        UserDefaults.standard.set(usernameTextField.text ?? "", forKey: "username")
        UserDefaults.standard.synchronize()
        let user: User? = User(name: usernameTextField.text ?? "", password: passwordTextField.text ?? "")
        DispatchQueue.main.async {
            NetworkConnectivity.login(user: user!)
            print("login button, userList?.users:")
            print(NetworkConnectivity.userList?.users)
        }
        performSegue(withIdentifier: "LoginSegue", sender: nil)
    }
    
}

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("begin")
    }
    
    // handling return button should be in "textFieldShouldReturn".
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


