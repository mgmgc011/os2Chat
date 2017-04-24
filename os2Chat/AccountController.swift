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
    
    
    
    
    lazy var saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Save", for: .normal)
        button.setTitleColor(UIColor.oraColor(), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.sizeToFit()
//        button.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "OraChat"

        print("AccountController loaded!")
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(AccountCell.self, forCellReuseIdentifier: cellId)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: saveButton)

        
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
        return 4
    }
    
    
}
