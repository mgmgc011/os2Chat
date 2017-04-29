//
//  User.swift
//  os2Chat
//
//  Created by Mingu Chu on 4/27/17.
//  Copyright © 2017 Chingoo. All rights reserved.
//

import UIKit
import SwiftyJSON



struct User {
    var id: Int?
    var name: String?
    var email: String?

    init(json: JSON) {
        id = json["id"].int
        name = json["name"].string
        email = json["email"].string
    
    }
    

}
