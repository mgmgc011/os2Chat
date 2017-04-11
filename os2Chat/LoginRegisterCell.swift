
//  LoginRegisterView.swift
//  os2Chat
//
//  Created by Mingu Chu on 4/10/17.
//  Copyright © 2017 Chingoo. All rights reserved.
//

import UIKit


class LoginRegisterCell: UITableViewCell, UITextFieldDelegate {
    
    
    
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        addSubview(label)
        label.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8).isActive = true
        label.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        label.widthAnchor.constraint(equalToConstant: 80).isActive = true
        label.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
        
        addSubview(inputTextField)
        inputTextField.leftAnchor.constraint(equalTo: label.rightAnchor, constant: 8).isActive = true
        inputTextField.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        inputTextField.rightAnchor.constraint(equalTo: rightAnchor, constant: -8).isActive = true
        inputTextField.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let label: UILabel = {
        let lb = UILabel()
        lb.text = "Sample"
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.backgroundColor = UIColor.white
        lb.textColor = UIColor.black
        return lb
    }()
    
    lazy var inputTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "placeHolderSample"
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.delegate = self
        return tf
    }()
    
    
    
    
    
    
    
    
    
}


extension LoginRegisterController {
    
    
    static let barButtonColor = UIColor(r: 247, g: 167, b: 0)
    
    func setUpNavigationBar() {
        navigationItem.title = "OraChat"
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.isTranslucent = false
        
    }
    
    func setUpInitialNavBarItems() {
        let switchButton = UIButton(type: .system)
        switchButton.setTitle("Register", for: .normal)
        switchButton.setTitleColor(LoginRegisterController.barButtonColor, for: .normal)
        switchButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        switchButton.sizeToFit()
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: switchButton)
        
        let actionButton = UIButton(type: .system)
        actionButton.setTitle("Login", for: .normal)
        actionButton.setTitleColor(LoginRegisterController.barButtonColor, for: .normal)
        actionButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        actionButton.sizeToFit()
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: actionButton)
    }
    
    
    
    
    
    
}
