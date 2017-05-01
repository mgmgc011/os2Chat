//
//  ViewController.swift
//  os2Chat
//
//  Created by Mingu Chu on 4/10/17.
//  Copyright © 2017 Chingoo. All rights reserved.
//

import UIKit


class LoginRegisterController: UITableViewController, UINavigationControllerDelegate, UITextFieldDelegate {
    
    let cellId = "cellId"
    let loginLabels = ["Email", "Password"]
    let registerLabels = ["Name","Email", "Password", "Confirm"]
    let register = "Register"
    let login = "Login"
    
    var nameTF: UITextField?
    var emailTF: UITextField?
    var passwordTF: UITextField?
    var confirmTF: UITextField?
    
    var nameText: String?
    var emailText: String?
    var passwordText: String?
    var confirmText: String?
    
    lazy var switchButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Register", for: .normal)
        button.setTitleColor(UIColor.oraColor(), for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        button.sizeToFit()
        button.addTarget(self, action: #selector(action_loginRegisterState), for: .touchUpInside)
        return button
    }()
    
    lazy var actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.setTitleColor(UIColor.oraColor(), for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        button.sizeToFit()
        button.addTarget(self, action: #selector(action_loginRegisterAttempt), for: .touchUpInside)
        return button
    }()
    
    let apiManager = APIManager.sharedInstance
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "OraChat"
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: switchButton)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: actionButton)
        tableView.register(AccountCell.self, forCellReuseIdentifier: cellId)
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let switchButtonState = switchButton.currentTitle == register ? loginLabels.count : registerLabels.count
        return switchButtonState
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! AccountCell
        let switchButtonState = switchButton.currentTitle == register ? loginLabels : registerLabels
        let labels = switchButtonState[indexPath.row]
        cell.label.text = labels
        
        switch cell.label.text! {
        case "Name":
            nameTF = cell.inputTextField
        case "Email":
            emailTF = cell.inputTextField
            cell.inputTextField.isSecureTextEntry = false
        case "Password":
            passwordTF = cell.inputTextField
            cell.inputTextField.isSecureTextEntry = true
        case "Confirm":
            confirmTF = cell.inputTextField
            cell.inputTextField.isSecureTextEntry = true
        default: break
        }
        
        return cell
    }
    
    func syncInputText() {
        nameText = nameTF?.text
        emailText = emailTF?.text
        passwordText = passwordTF?.text
        confirmText = confirmTF?.text
    }
    
    
    func action_loginRegisterState() {
        let switchButtonTitle = switchButton.currentTitle == register ? login : register
        let actionButtonTitle = actionButton.currentTitle == login ? register : login
        
        self.switchButton.setTitle(switchButtonTitle, for: .normal)
        self.actionButton.setTitle(actionButtonTitle, for: .normal)
        self.actionButton.sizeToFit()
        
        self.tableView.reloadData()
    }
    
    func action_loginRegisterAttempt() {
        syncInputText()
        let titleLabel = actionButton.titleLabel?.text
        let tabBarController = CustomTabBarController()
        
        switch titleLabel! {
        case register:
            apiManager.register(name: nameText!, email: emailText!, pw: passwordText!, confirmPw: confirmText!) { (result, message) in
                
                if result == true {
                    let action = UIAlertAction(title: "Okay", style: UIAlertActionStyle.default, handler: { (action) in
                        self.action_loginRegisterState()
                    })
                    self.errorAlert(message, message: "Please sign in", action: action)
                } else {
                    let action = UIAlertAction(title: "Okay", style: UIAlertActionStyle.default, handler: nil)
                    self.errorAlert("Register Failed", message: "Please Try Again", action: action)
                }
                
            }
            
        case login:
            apiManager.login(email: emailText!, pw: passwordText!, completion: { (result, message) in
                
                if result == true {
                    self.present(tabBarController, animated: true, completion: nil)
                }
                
            })
            
        default: break
        }
    }
    
    
    func errorAlert(_ title: String, message: String, action: UIAlertAction) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}




