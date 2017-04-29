//
//  ChatListController.swift
//  os2Chat
//
//  Created by Mingu Chu on 4/11/17.
//  Copyright © 2017 Chingoo. All rights reserved.
//

import UIKit

class ChatListController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let cellId = "cellId"
    let headerId = "headerId"
    
    lazy var tableView : UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = .clear
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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        navigationItem.title = "OraChat"
        
        tableView.register(ChatListCell.self, forCellReuseIdentifier: cellId)
        tableView.register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: headerId)

        
        view.addSubview(inputSearchBarView)
        inputSearchBarView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
        inputSearchBarView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        inputSearchBarView.widthAnchor.constraint(equalToConstant: self.view.frame.size.width).isActive = true
                
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: inputSearchBarView.bottomAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        tableView.widthAnchor.constraint(equalToConstant: self.view.frame.size.width).isActive = true
        tableView.heightAnchor.constraint(equalToConstant: self.view.frame.size.height - inputSearchBarView.frame.size.height).isActive = true
        
        view.addSubview(addButton)
        addButton.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor, constant : -12).isActive = true
        addButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -12).isActive = true
        addButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        addButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 24
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ChatListCell
        cell.textLabel?.text = "From Bella"
        cell.detailTextLabel?.text = "Time ago"
        cell.messageLabel.text = "Yo YO yo yO"
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerId)
        header?.textLabel?.text = "Today"
        
        return header
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let chatLogController = ChatLogController()

        self.navigationController?.pushViewController(chatLogController, animated: true)
    
    }
    
    
    
    
    
}
