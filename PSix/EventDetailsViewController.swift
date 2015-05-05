//
//  EventDetailsViewController.swift
//  PSix
//
//  Created by Turzion, Avihu on 5/5/15.
//  Copyright (c) 2015 PayPal. All rights reserved.
//

import UIKit

class EventDetailsViewController: UIViewController {
    
    @IBOutlet var baseView: UIView!
    @IBOutlet weak var emptyStateLabel: UILabel!
    
    private let emptyStateBackgroundColor = UIColor(red: 240, green: 240, blue: 240, alpha: 1)
    
    var event: Event? {
        didSet {
            updateUI()
        }
    }
    
    private func updateUI() {
        if let event = event {
            baseView.backgroundColor = UIColor.whiteColor()
            emptyStateLabel.hidden = true
        } else {
            emptyStateLabel.hidden = false
            baseView.backgroundColor = emptyStateBackgroundColor
        }
    }

}