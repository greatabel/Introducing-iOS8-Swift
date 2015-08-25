//
//  ViewController.swift
//  4ControlFun
//
//  Created by 万畅 on 15/8/24.
//  Copyright © 2015年 abelwan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var nameField: UITextField!

    @IBOutlet weak var numberField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func textFieldDoneEditing(sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    @IBAction func backgroundTap(sender:UIControl){
     nameField.resignFirstResponder()
     numberField.resignFirstResponder()
    }
    

}
