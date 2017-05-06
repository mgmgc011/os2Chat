//
//  ChatLogController.swift
//  os2Chat
//
//  Created by Mingu Chu on 4/15/17.
//  Copyright © 2017 Chingoo. All rights reserved.
//

import UIKit



class ChatLogController: UIViewController, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UINavigationControllerDelegate {
    
    
    let cellId = "cellId"
    
    let apiManager = APIManager.sharedInstance
    var seguedMessage: Message?
    var loadedMessages = [Message]()
    var currentUser: User?
    var seguedTitle: String?
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.contentInset = UIEdgeInsetsMake(8, 0, 8, 0)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        collectionView.alwaysBounceVertical = true
        return collectionView
    }()
    
    let addButton: AddButtonView = {
        let button = AddButtonView(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 25
        return button
    }()
    
    lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Back", for: .normal)
        button.setTitleColor(UIColor.oraColor(), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.sizeToFit()
        button.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        return button
    }()
    
    lazy var popupView: PopUpView = {
        let width = self.view.frame.width * 0.7
        let height = self.view.frame.height * 0.5
        let frame = CGRect(x: 0, y: 0, width: width, height: height)
        let popUp = PopUpView(frame: frame, actionButtonTitle: "Send", labelText: "Send A Message", parentViewController: 2)
        let navbarY = self.navigationController?.navigationBar.frame.height
        let tabbarY = self.tabBarController?.tabBar.frame.height
        let x = self.view.center.x
        let y = self.view.center.y - navbarY! - tabbarY!
        popUp.center.x = x
        popUp.center.y = y
        popUp.chatLogController = self
        return popUp
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        loadMessages()
        collectionView.register(ChatLogCollectionCell.self, forCellWithReuseIdentifier: cellId)
        navigationItem.title = seguedTitle
        
        view.addSubview(collectionView)
        collectionView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        collectionView.widthAnchor.constraint(equalToConstant: self.view.frame.size.width).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        view.addSubview(addButton)
        addButton.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor, constant : -12).isActive = true
        addButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -12).isActive = true
        addButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        addButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        addButton.addTarget(self, action: #selector(addPopUp), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        
    }
    
    func loadMessages() {
        
        if let chatId = seguedMessage?.chat_id {
            apiManager.listMessages(id: chatId, page: 1, limit: 20) { (messages, error) -> (Void) in
                if messages != nil, error == nil {
                    self.loadedMessages = messages!
                    
                    DispatchQueue.main.async(execute: {
                        self.collectionView.reloadData()
                    })
                    
                } else if error != nil {
                    let errorMessage = error?.localizedDescription
                    let retryAction = UIAlertAction(title: "Try Again", style: UIAlertActionStyle.default, handler: { (action) in
                        self.loadMessages()
                    })
                    let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: nil)
                    
                    self.errorAlert("Error Occoured", message: errorMessage!, action: retryAction, action2: cancelAction)
                }
            }
        }
    }
    
    
    func backAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func addPopUp() {
        view.addSubview(popupView)
    }
    
    func removePopUP() {
        popupView.removeFromSuperview()
    }
    
    func sendMesaage() {
        if let chatId = seguedMessage?.chat_id, let message = popupView.messageTextView.text {
            apiManager.sendMessage(id: chatId, message: message, completionHandler: { (result, message) in
                guard result == true else {
                    let action = UIAlertAction(title: "Try Again", style: UIAlertActionStyle.default, handler: { (action) in
                        self.sendMesaage()
                    })
                    let cancel = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: { (action) in
                        self.removePopUP()
                    })
                    
                    self.errorAlert("Error Occured", message: message, action: action, action2: cancel)
                    return
                }
                
                let action = UIAlertAction(title: "Okay", style: UIAlertActionStyle.default, handler: { (action) in
                    DispatchQueue.main.async(execute: {
                        self.removePopUP()
                        self.collectionView.reloadData()
                    })
                })
                self.errorAlert("Message Sent", message: message, action: action, action2: nil)
            })
        }
    }
    
    func setupCell(cell: ChatLogCollectionCell, message: Message) {
        if currentUser?.id == message.user_id {
            cell.bubbleViewRightAnchor?.isActive = true
            cell.bubbleViewLeftAnchor?.isActive = false
            cell.bubbleView.backgroundColor = UIColor.oraColor()
        } else {
            cell.bubbleViewRightAnchor?.isActive = false
            cell.bubbleViewLeftAnchor?.isActive = true
            cell.bubbleView.backgroundColor = UIColor.lightGray
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return loadedMessages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ChatLogCollectionCell
        let message = loadedMessages[indexPath.item]
        let text = message.message
        cell.textView.text = text
        cell.timeNameLabel.text = message.created_at?.converToString()
        setupCell(cell: cell, message: message)
        cell.bubbleViewWidthAnchor?.constant = estimateFrameForText(text: text!).width + 32
        
        return cell
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var height: CGFloat = 100
        let width = UIScreen.main.bounds.width
        let message = loadedMessages[indexPath.item]
        let text = message.message
        height = estimateFrameForText(text: text!).height + 50
    
        return CGSize(width: width, height: height)
    }
    
    func estimateFrameForText(text: String) -> CGRect {
        let size = CGSize(width: 250, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let attributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 16)]
        let rect = NSString(string: text).boundingRect(with: size, options: options, attributes: attributes, context: nil)
        
        return rect
    }
    
    
    func errorAlert(_ title: String, message: String, action: UIAlertAction, action2: UIAlertAction?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(action)
        
        if action2 != nil {
            alert.addAction(action2!)
        }
        
        present(alert, animated: true, completion: nil)
    }
    
    
}
