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

        print("AccountController loaded!")
        
        tableView.register(AccountCell.self, forCellReuseIdentifier: cellId)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: saveButton)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: logoutButton)
        
        apiManager.readCurrentUser { (user) -> (Void) in
            
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! AccountCell
        let labels = registerLabels[indexPath.row]
        cell.inputTextField.text = ""
        cell.label.text = labels
        
        if cell.label.text == "Password" || cell.label.text == "Confirm" {
            cell.inputTextField.isSecureTextEntry = true
        } else {
            cell.inputTextField.isSecureTextEntry = false
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return registerLabels.count
    }
    
    func syncInputText() {
        nameText = nameTF?.text
        emailText = emailTF?.text
        passwordText = passwordTF?.text
        confirmText = confirmTF?.text
    }
    
    
    func saveUserInfo() {
        syncInputText()
        
        
    }
    
    func logoutUser() {
        apiManager.logout { (result) in
            if result == true {
                self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
                
                
            }
        }
    }
    
}
