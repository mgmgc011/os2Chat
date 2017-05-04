//
//  AddPopUpView.swift
//  os2Chat
//
//  Created by Mingu Chu on 4/20/17.
//  Copyright © 2017 Chingoo. All rights reserved.
//

import UIKit


class PopUpView: UIView {
    
    
    var chatListController: ChatListController? {
        didSet {
            cancelButton.addTarget(chatListController, action: #selector(ChatListController.removePopUp), for: .touchUpInside)
            
            createButton.addTarget(chatListController, action: #selector(ChatListController.createChat), for: .touchUpInside)
        }
    }
    
    var chatLogController: ChatLogController? {
        didSet {
            
            
        }
    }
    
    
    
    let titleLabel: UILabel = {
        let lb = UILabel()
        lb.font = UIFont.systemFont(ofSize: 16)
        lb.textColor  = .white
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.textAlignment = .center
        lb.layer.cornerRadius = 10
        lb.clipsToBounds = true
        lb.backgroundColor = UIColor.oraColor()
        return lb
    }()
    
    let titleTextField: UITextField = {
        let tf = UITextField()
        tf.font = UIFont.systemFont(ofSize: 16)
        tf.layer.borderWidth = 1.0
        tf.layer.borderColor = UIColor.oraColor().cgColor
        tf.backgroundColor = .white
        tf.layer.cornerRadius = 10
        tf.textAlignment = .center
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Name the Chat"
       return tf
    }()
    
    let messageTextView: UITextView = {
        let tv = UITextView()
        tv.font = UIFont.systemFont(ofSize: 16)
        tv.layer.borderWidth = 1.0
        tv.layer.borderColor = UIColor.oraColor().cgColor
        tv.layer.cornerRadius = 10
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    
    let createButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.oraColor()
        button.tintColor = .white
        button.layer.borderColor = UIColor.oraColor().cgColor
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1.0
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        return button
    }()
    
    let cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.oraColor()
        button.tintColor = .white
        button.layer.borderColor = UIColor.oraColor().cgColor
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1.0
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.setTitle("Cancel", for: .normal)
        return button
    }()
    
    
    init(frame: CGRect, actionButtonTitle: String, labelText: String, parentViewController: Int) {
        super.init(frame: frame)
        
        backgroundColor = .clear
        titleLabel.text = labelText
        createButton.setTitle(actionButtonTitle, for: .normal)
        addSharedViews()
        
        if parentViewController == 1 {
            addTitleView()
            handleChatMessageChange(topAnchor: titleTextField.bottomAnchor)
            
        } else if parentViewController == 2 {
            handleChatMessageChange(topAnchor: titleLabel.bottomAnchor)
            
        }
        
        
    }
    
    
    func addSharedViews() {
        self.addSubview(createButton)
        createButton.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        createButton.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        createButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.495).isActive = true
        createButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        self.addSubview(cancelButton)
        cancelButton.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        cancelButton.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        cancelButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.495).isActive = true
        cancelButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        self.addSubview(titleLabel)
        titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        titleLabel.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func addTitleView() {
        self.addSubview(titleTextField)
        titleTextField.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        titleTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5).isActive = true
        titleTextField.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        titleTextField.heightAnchor.constraint(equalToConstant: 35).isActive = true
    }
    
    func handleChatMessageChange(topAnchor: NSLayoutYAxisAnchor) {
        self.addSubview(messageTextView)
        messageTextView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        messageTextView.topAnchor.constraint(equalTo: topAnchor, constant: 3).isActive = true
        messageTextView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        messageTextView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -53).isActive = true
        
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
    
}
