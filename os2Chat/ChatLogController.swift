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
    
    var message: Message?
    
    let messages = ["Hi", "This is a very long text for manual testing cases so, lets see if i know the alphabet abcdefghijklmnopqrstuvwxyz nice", "This is a very long text for manual testing cases so, lets see if i know the alphabet abcdefghijklmnopqrstuvwxyz nice, This is a very long text for manual testing cases so, lets see if i know the alphabet abcdefghijklmnopqrstuvwxyz nice", "This is a very long text for manual testing cases so, lets see if i know the alphabet abcdefghijklmnopqrstuvwxyz nice, This is a very long text for manual testing cases so, lets see if i know the alphabet abcdefghijklmnopqrstuvwxyz niceThis is a very long text for manual testing cases so, lets see if i know the alphabet abcdefghijklmnopqrstuvwxyz nice, This is a very long text for manual testing cases so, lets see if i know the alphabet abcdefghijklmnopqrstuvwxyz niceThis is a very long text for manual testing cases so, lets see if i know the alphabet abcdefghijklmnopqrstuvwxyz nice, This is a very long text for manual testing cases so, lets see if i know the alphabet abcdefghijklmnopqrstuvwxyz niceThis is a very long text for manual testing cases so, lets see if i know the alphabet abcdefghijklmnopqrstuvwxyz nice, This is a very long text for manual testing cases so, lets see if i know the alphabet abcdefghijklmnopqrstuvwxyz nice"]
    
    
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
//        let popUp = PopUpView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        let navbarY = self.navigationController?.navigationBar.frame.height
        let tabbarY = self.tabBarController?.tabBar.frame.height
        let x = self.view.center.x
        let y = self.view.center.y - navbarY! - tabbarY!
        popUp.center.x = x
        popUp.center.y = y

        return popUp
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(ChatLogCollectionCell.self, forCellWithReuseIdentifier: cellId)
        
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
    
    
    func backAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func addPopUp() {
        view.addSubview(popupView)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ChatLogCollectionCell
        let text = messages[indexPath.item]
        
        cell.textView.text = text
        cell.bubbleViewWidthAnchor?.constant = estimatedFrameForText(text: text).width + 32
        
        return cell
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var height: CGFloat = 100
        let width = UIScreen.main.bounds.width
        let message = messages[indexPath.item]
        
        height = estimatedFrameForText(text: message).height + 50
        
        
        return CGSize(width: width, height: height)
    }
    
    private func estimatedFrameForText(text: String) -> CGRect {
        let size = CGSize(width: 250, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let attributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 16)]
        let rect = NSString(string: text).boundingRect(with: size, options: options, attributes: attributes, context: nil)
        
        return rect
    }
    
    
    
}
