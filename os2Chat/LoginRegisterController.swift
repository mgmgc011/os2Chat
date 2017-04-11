//
//  ViewController.swift
//  os2Chat
//
//  Created by Mingu Chu on 4/10/17.
//  Copyright © 2017 Chingoo. All rights reserved.
//

import UIKit


class LoginRegisterController: UITableViewController, UINavigationControllerDelegate {

    let cellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(LoginRegisterCell.self, forCellReuseIdentifier: cellId)
        
        setUpNavigationBar()
        setUpInitialNavBarItems()
        
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! LoginRegisterCell
        cell.label.text = "Password"
        
        
        
        return cell
    }
    

        
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}




