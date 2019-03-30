//
//  StartView.swift
//  InLine
//
//  Created by Emmett Shaughnessy on 3/30/19.
//  Copyright © 2019 Emmett Shaughnessy. All rights reserved.
//

import UIKit

class StartView: UIViewController {

    let YourQueuePosition = Double()
    let currentQueuePosition = Double()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        Timer.scheduledTimer(timeInterval: 3.5, target: self, selector: #selector(timeToMoveOn), userInfo: nil, repeats: false)
        
    }
    
    @objc func timeToMoveOn() {
        self.performSegue(withIdentifier: "goToMainUI", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "goToMainUI") {
            
            let dest = segue.destination as! IntroViewController // viewTwo is your destination ViewController
            dest.YourQueuePosition = YourQueuePosition
            dest.currentQueuePosition = currentQueuePosition
            
            print("Segue Performed")
            
        }
        
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
