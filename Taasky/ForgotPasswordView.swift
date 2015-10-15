//
//  ViewController.swift
//  Kitchen.Support
//
//  Created by Darrell Shi on 9/29/15.
//  Copyright © 2015 Darrell Shi. All rights reserved.
//

import UIKit

class ForgotPasswordView: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var textbox_email: UITextField!
    var email: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        textbox_email.delegate = self
        
        if email != "" {
            textbox_email.text = email
        }
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

