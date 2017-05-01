//
//  AccountController.swift
//  os2Chat
//
//  Created by Mingu Chu on 4/11/17.
//  Copyright © 2017 Chingoo. All rights reserved.
//

import UIKit


class AccountController: UITableViewController {
    
    let registerLabels = ["Name","Email", "Password", "Confirm"]
    let cellId = "cellId"
    
    var nameTF: UITextField?
    var emailTF: UITextField?
    var passwordTF: UITextField?
    var confirmTF: UITextField?
    
    var nameText: String?
    var emailText: String?
    var passwordText: String?
    var confirmText: String?
    
    let apiManager = APIManager.sharedInstance
    var currentUser: User?
    
    lazy var saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Save", for: .normal)
        button.setTitleColor(UIColor.oraColor(), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.sizeToFit()
        button.addTarget(self, action: #selector(saveUserInfo), for: .touchUpInside)
        return button
    }()
    
    
    lazy var logoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Logout", for: .normal)
        button.setTitleColor(UIColor.oraColor(), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.sizeToFit()
        button.addTarget(self, action: #selector(logoutUser), for: .touchUpInside)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "OraChat"
        
        fetchCurrentUser()
        tableView.register(AccountCell.self, forCellReuseIdentifier: cellId)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: saveButton)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: logoutButton)
        
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! AccountCell
        let labels = registerLabels[indexPath.row]
        cell.label.text = labels
        
        switch cell.label.text! {
        case "Name":
            cell.inputTextField.text = currentUser?.name
            nameTF = cell.inputTextField
        case "Email":
            cell.inputTextField.text = currentUser?.email
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
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return registerLabels.count
    }
    
    
    func fetchCurrentUser() {
        apiManager.readCurrentUser { (user) -> (Void) in
            self.currentUser = user
            DispatchQueue.main.async(execute: {
                self.tableView.reloadData()
            })
        }
    }
    
    func syncInputText() {
        nameText = nameTF?.text
        emailText = emailTF?.text
        passwordText = passwordTF?.text
        confirmText = confirmTF?.text
    }
    
    
    func saveUserInfo() {
        syncInputText()
        apiManager.updateCurrentUser(name: nameText!, email: emailText!, pw: passwordText!, confirmPw: confirmText!) { (result, message) in
            if result == true {
                let action = UIAlertAction(title: "Okay", style: UIAlertActionStyle.default, handler: nil)
                self.errorAlert("Updated", message: message, action: action)
            }
        }
        
    }
    
    func logoutUser() {
        apiManager.logout { (result) in
            if result == true {
                let action = UIAlertAction(title: "Okay", style: UIAlertActionStyle.default, handler: { (action) in
                    self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
                    
                })
                self.errorAlert("Logout", message: "Sucessfully Logged Out!", action: action)
                
            }
        }
    }
    
    func errorAlert(_ title: String, message: String, action: UIAlertAction) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
}
