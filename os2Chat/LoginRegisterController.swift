//
//  ViewController.swift
//  os2Chat
//
//  Created by Mingu Chu on 4/10/17.
//  Copyright © 2017 Chingoo. All rights reserved.
//

import UIKit


class LoginRegisterController: UITableViewController, UINavigationControllerDelegate {
    
    let cellId = "cellId"
    let loginLabels = ["Email", "Password"]
    let registerLabels = ["Name","Email", "Password", "Confirm"]
    
    let switchButton = UIButton(type: .system)
    let actionButton = UIButton(type: .system)
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(LoginRegisterCell.self, forCellReuseIdentifier: cellId)
        
        setUpNavigationBar()
        setUpInitialNavBarItems()
        
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let switchButtonState = switchButton.currentTitle == "Register" ? registerLabels.count : loginLabels.count
        
        
        
        return switchButtonState
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! LoginRegisterCell
        let switchButtonState = switchButton.currentTitle == "Register" ? registerLabels : loginLabels
        let labels = switchButtonState[indexPath.row]
        cell.inputTextField.text = ""
        cell.label.text = labels
        
        if cell.label.text == "Password" || cell.label.text == "Confirm" {
            cell.inputTextField.isSecureTextEntry = true
        } else {
            cell.inputTextField.isSecureTextEntry = false
        }
        
        return cell
    }
    
    
    
    func action_loginRegisterState() {
        let switchButtonTitle = switchButton.currentTitle == "Register" ? "Login" : "Register"
        let actionButtonTitle = actionButton.currentTitle == "Login" ? "Register" : "Login"
        
        switchButton.setTitle(switchButtonTitle, for: .normal)
        actionButton.setTitle(actionButtonTitle, for: .normal)
        actionButton.sizeToFit()
        
        self.tableView.reloadData()
        
    }
    
    func action_loginRegisterAttempt() {
        
        let tabBarController = CustomTabBarController()
        present(tabBarController, animated: true, completion: nil)
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}




