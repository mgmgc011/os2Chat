
//  LoginRegisterView.swift
//  os2Chat
//
//  Created by Mingu Chu on 4/10/17.
//  Copyright © 2017 Chingoo. All rights reserved.
//

import UIKit


class AccountCell: UITableViewCell, UITextFieldDelegate {
    
    
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
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.backgroundColor = UIColor.white
        lb.textColor = UIColor.black
        lb.textAlignment = .center
        return lb
    }()
    
    lazy var inputTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "enter here"
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.textAlignment = .center
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.delegate = self
        return tf
    }()
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
    
    
    
    
}



