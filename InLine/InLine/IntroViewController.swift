//
//  IntroViewController.swift
//  InLine
//
//  Created by Emmett Shaughnessy on 3/30/19.
//  Copyright © 2019 Emmett Shaughnessy. All rights reserved.
//

import UIKit
import Foundation

class IntroViewController: UIViewController {

    
    var YourQueuePosition = Double()
    var currentQueuePosition = Double()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var YourPosition: UITextField!
    @IBOutlet weak var currentPosition: UITextField!
    

    
    @IBAction func trackIt(_ sender: Any) {
        YourQueuePosition = Double(YourPosition.text!)!
        currentQueuePosition = Double(currentPosition.text!)!
        
        self.performSegue(withIdentifier: "goToMainView", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "goToMainView") {
            
            let dest = segue.destination as! ViewController // viewTwo is your destination ViewController
            dest.YourQueuePosition = Double(YourPosition.text!)!
            dest.currentQueuePosition = Double(currentPosition.text!)!
            
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

extension UITextField{
    
    @IBInspectable var doneAccessory: Bool{
        get{
            return self.doneAccessory
        }
        set (hasDone) {
            if hasDone{
                addDoneButtonOnKeyboard()
            }
        }
    }
    
    func addDoneButtonOnKeyboard()
    {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
        
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.inputAccessoryView = doneToolbar
    }
    
    @objc func doneButtonAction()
    {
        self.resignFirstResponder()
    }
}
