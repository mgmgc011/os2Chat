//
//  ChatListController.swift
//  os2Chat
//
//  Created by Mingu Chu on 4/11/17.
//  Copyright © 2017 Chingoo. All rights reserved.
//

import UIKit

class ChatListController: UIViewController {
    
    let cellId = "cellId"
    let headerId = "headerId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        navigationItem.title = "OraChat"
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.isTranslucent = false
        
        view.addSubview(inputSearchBarView)
        inputSearchBarView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
        inputSearchBarView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        inputSearchBarView.widthAnchor.constraint(equalToConstant: self.view.frame.size.width).isActive = true
        
        view.addSubview(inputTableView)
        inputTableView.topAnchor.constraint(equalTo: inputSearchBarView.bottomAnchor).isActive = true
        inputTableView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        inputTableView.widthAnchor.constraint(equalToConstant: self.view.frame.size.width).isActive = true
        inputTableView.heightAnchor.constraint(equalToConstant: self.view.frame.size.height - inputSearchBarView.frame.size.height).isActive = true

        view.addSubview(addButton)
        addButton.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor, constant : -12).isActive = true
        addButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -12).isActive = true
        addButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        addButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        
    }
    
    
    
    
    lazy var inputTableView: ChatListTableView = {
//        let tableView = ChatListTableView(frame: .zero)
        let tableView = ChatListTableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    lazy var inputSearchBarView: SearchBarView = {

        let searchBarView = SearchBarView(frame: .zero)
        searchBarView.translatesAutoresizingMaskIntoConstraints = false
        return searchBarView
    }()
    
    let addButton: AddButtonView = {
       let button = AddButtonView(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 25
        return button
    }()
    
    
    


    
    
}
