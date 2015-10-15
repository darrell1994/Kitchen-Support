//
//  ViewController.swift
//  Kitchen.Support
//
//  Created by Darrell Shi on 9/29/15.
//  Copyright © 2015 Darrell Shi. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var textbox_email: UITextField!
    @IBOutlet weak var textbox_pw: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var email: String?
    var pw: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textbox_pw.delegate = self
        textbox_email.delegate = self
        
        // Set email and password from SignupView
        if email != nil {
            textbox_email.text = email
        }
        if pw != nil {
            textbox_pw.text = pw
        }
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "login2forgetPassword" {
            let vc = segue.destinationViewController as! ForgotPasswordView
            vc.email = textbox_email.text
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == self.textbox_email {
            self.textbox_pw.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
            loginClicked(self)
        }
        return true
    }
    
    @IBAction func loginClicked(sender: AnyObject) {
        if checkArguments() {
            activityIndicator.startAnimating()
            dispatch_async(dispatch_get_main_queue()) {
                self.sendLoginRequest()
            }
        }
    }
    
    private func checkArguments() -> Bool {
        if textbox_email.text == ""  || textbox_pw.text == "" {
            let alert = UIAlertController(title: "Missing arguments", message: "Please provide email address and password", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            return false
        } else {
            return true
        }
    }
    
    private func getStatus(responce: String)->String {
        let index1 = responce.characters.indexOf(":")
        let string1 = responce.substringFromIndex(index1!.advancedBy(2))
        let index2 = string1.characters.indexOf(",")
        let string2 = string1.substringToIndex(index2!.advancedBy(-1))
        return string2
    }
    
    private func alertView(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    var response = NSString()
    private func sendLoginRequest() {
        let headers = ["content-type": "application/json"]
        let parameters = [
            "email": textbox_email.text! as String,
            "password": textbox_pw.text! as String
        ]
        
        let request = NSMutableURLRequest(URL: NSURL(string: "http://api.kitchen.support/accounts/login")!,
            cachePolicy: .UseProtocolCachePolicy,
            timeoutInterval: 10.0)
        request.HTTPMethod = "POST"
        request.allHTTPHeaderFields = headers
        
        do {
            let postData = try NSJSONSerialization.dataWithJSONObject(parameters, options: NSJSONWritingOptions.PrettyPrinted)
            request.HTTPBody = postData
            
        } catch {
            print("Error with NSJSONSerialization")
        }
        
        let session = NSURLSession.sharedSession()
        let dataTask = session.dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error)
            } else {
//                let httpResponse = response as? NSHTTPURLResponse
                self.response = NSString(data: data!, encoding: NSUTF8StringEncoding)!
                print(self.response)
                dispatch_async(dispatch_get_main_queue()) {
                    self.handleResponse()
                }
            }
        })
        dataTask.resume()
    }
    
    private func handleResponse() {
        let status = getStatus(response as String)
        if status == "success" {
            print("login success")
            performSegueWithIdentifier("showSegueToContainerView", sender: nil)
        } else {
            print("login failure")
            activityIndicator.stopAnimating()
            alertView("Failure", message: "Invalid email or password")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

