//
//  CurrentUser.swift
//  PSix
//
//  Created by Turzion, Avihu on 4/14/15.
//  Copyright (c) 2015 PayPal. All rights reserved.
//

import Foundation
import Parse

class CurrentUser {
    
    private init() {}
    
    static func get() -> PFUser? {
        return PFUser.currentUser()
    }
    
    static func isLoggedIn() -> Bool {
        return get() != nil
    }
    
    static func logout() {
        PFUser.logOut()
    }
    
}