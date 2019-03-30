//
//  ViewController.swift
//  InLine
//
//  Created by Emmett Shaughnessy on 3/30/19.
//  Copyright © 2019 Emmett Shaughnessy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        timeRemaining.text = "\(hours) hours and \(minuets) minutes"
    }
    
    var timeSetup1 = 1
    var hours = 1
    var minuets = 1
    
    @IBOutlet weak var queueNumber: UILabel!
    @IBOutlet weak var timeRemaining: UILabel!
    
    func findQueueTime() {
        let queue:Double = Double(queueNumber!.text!)!
        timeSetup1 = Int(100+(queue * 0.3))
        
        
    }
    
    
    
}

