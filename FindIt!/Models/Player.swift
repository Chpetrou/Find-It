//
//  Player.swift
//  FindIt!
//
//  Created by Christos Petrou on 05/03/2019.
//  Copyright © 2019 Christos Petrou. All rights reserved.
//

import UIKit

class Player {
    var username = ""
    var points = 0
    
    required init(username: String) {
        self.username = username
        self.points = 0
    }
}
