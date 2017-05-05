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
    
    let apiManager = APIManager.sharedInstance
    var chats: [Chat] = []
    var currentUser: User? {
        didSet {
            let navController = self.tabBarController?.viewControllers?[1] as! UINavigationController
            let vc = navController.topViewController as! AccountController
            vc.currentUser = self.currentUser
        }
    }
    
    
    
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
        button.addTarget(self, action: #selector(addPopUp), for: .touchUpInside)
        return button
    }()
    
    lazy var popupView: PopUpView = {
        let width = self.view.frame.width * 0.7
        let height = self.view.frame.height * 0.5
        let frame = CGRect(x: 0, y: 0, width: width, height: height)
        let popUp = PopUpView(frame: frame, actionButtonTitle: "Create", labelText: "Create A Chat", parentViewController: 1)
        let navbarY = self.navigationController?.navigationBar.frame.height
        let tabbarY = self.tabBarController?.tabBar.frame.height
        let x = self.view.center.x
        let y = self.view.center.y - navbarY! - tabbarY!
        popUp.center.x = x
        popUp.center.y = y
        popUp.chatListController = self
        return popUp
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchChatList()
        fetchCurrentUser()
        
        navigationItem.title = "OraChat"
        navigationController?.navigationBar.barTintColor = .white
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
    
    
    func fetchCurrentUser() {
        apiManager.readCurrentUser { (user) -> (Void) in
            if let fetchedUser = user {
                self.currentUser = fetchedUser
            }
        }
    }
    
    func fetchChatList() {
        apiManager.listChat(page: 1, limit: 50) { (chats) in
            self.chats = chats
            DispatchQueue.main.async(execute: {
                self.tableView.reloadData()
            })
        }
    }
    
    func addPopUp() {
        view.addSubview(popupView)
    }
    
    func removePopUp() {
        popupView.removeFromSuperview()
    }
    
    func createChat() {
        apiManager.createChat(name: popupView.titleTextField.text!, message: popupView.messageTextView.text) { (result) in
            if result == true {
                
                let action = UIAlertAction(title: "Okay", style: UIAlertActionStyle.default, handler: { (action) in
                    self.tableView.reloadData()
                    self.removePopUp()
                    
                })
                self.errorAlert("Created", message: "Yep", action: action)
            } else {
                let action = UIAlertAction(title: "Okay", style: UIAlertActionStyle.default, handler: nil)
                self.errorAlert("Error", message: "Something went wrong!", action: action)
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 24
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chats.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return chats.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ChatListCell
        let chat = chats[indexPath.row]
        
        cell.textLabel?.text = chat.name
        let formattedTime = chat.last_chat_message?.created_at
        let fromAndName = "From:\(chat.users.first!.name!), \(formattedTime!)"
        cell.detailTextLabel?.text = fromAndName
        cell.messageLabel.text = chat.last_chat_message?.message
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerId)
        header?.textLabel?.text = "Today"
        
        return header
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let chatLogController = ChatLogController()
        chatLogController.currentUser = self.currentUser
        chatLogController.seguedMessage = chats[indexPath.row].last_chat_message
        chatLogController.seguedTitle = chats[indexPath.row].name
        self.navigationController?.pushViewController(chatLogController, animated: true)
        
    }
    
    
    func errorAlert(_ title: String, message: String, action: UIAlertAction) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let edit = UITableViewRowAction(style: .normal, title: "Edit") { (action, index) in
            print("Edit pressed")
        }
        
        edit.backgroundColor = UIColor.oraColor()
        
        return [edit]
    }
    
}


















