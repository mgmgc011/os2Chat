//
//  CustomTabBarController.swift
//  os2Chat
//
//  Created by Mingu Chu on 4/11/17.
//  Copyright © 2017 Chingoo. All rights reserved.
//

import UIKit

class CustomTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let chatListController = ChatListController(collectionViewLayout: UICollectionViewFlowLayout())
        let chatNavigationController = UINavigationController(rootViewController: chatListController)
        chatNavigationController.title = "Chat"
        chatNavigationController.tabBarItem.image = UIImage(named: "icon_ios_list")
        
        
        let accountController = AccountController()
        let accountNavigationController = UINavigationController(rootViewController: accountController)
        accountNavigationController.title = "Account"
        accountNavigationController.tabBarItem.image = UIImage(named: "icon_ios_user")
        
        viewControllers = [chatNavigationController, accountNavigationController]
        
        
    }
    
    
}
