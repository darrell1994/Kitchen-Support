//
//  SignupViewController.swift
//  KitchenSupport
//
//  Created by Darrell Shi on 10/13/15.
//  Copyright © 2015 Purdue University. All rights reserved.
//

import Foundation
import UIKit

class SignupViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var textbox_firstName: UITextField!
    @IBOutlet weak var textbox_lastName: UITextField!
    @IBOutlet weak var textbox_email: UITextField!
    @IBOutlet weak var textbox_pw: UITextField!
    @IBOutlet weak var textbox_pwConformation: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textbox_firstName.delegate = self
        textbox_lastName.delegate = self
        textbox_email.delegate = self
        textbox_pw.delegate = self
        textbox_pwConformation.delegate = self
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "signupToLogin" {
            let vc = segue.destinationViewController as! LoginViewController
            if textbox_email.text != "" {
                vc.email = textbox_email.text
            }
            if textbox_pw.text != "" {
                vc.pw = textbox_pw.text
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func alertView(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    private func checkPasswordConformation()->Bool {
        if textbox_pw.text == textbox_pwConformation.text {
            return true
        } else {
            return false
        }
    }
    
    @IBAction func signupClicked(sender: AnyObject) {
        if checkArguments() {
            if checkPasswordConformation() {
                activityIndicator.startAnimating()
                dispatch_async(dispatch_get_main_queue()) {
                    self.sendSignupRequest()
                }
            } else {
                alertView("Please check password", message: "Password and conformation don't match!")
            }
        }
    }
    
    private func checkArguments() -> Bool {
        if textbox_email.text == ""  || textbox_pw.text == "" || textbox_firstName.text == "" || textbox_lastName.text == "" || textbox_pwConformation.text == "" {
            alertView("Missing arguments", message: "Please provide all the information")
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
    
    var response = NSString()
    private func sendSignupRequest() {
        let headers = ["content-type": "application/json"]
        let parameters = [
            "email": textbox_email.text! as String,
            "password": textbox_pw.text! as String
        ]
        
        let request = NSMutableURLRequest(URL: NSURL(string: "http://api.kitchen.support/accounts/create")!,
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
        activityIndicator.stopAnimating()
        if status == "success" {
            print("signup success")
            alertView("Success", message: "Hi \(textbox_firstName.text!), welcome to Kitchen Support!")
        } else {
            print("signup failure")
            alertView("Failure", message: "Failed to sign up")
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == self.textbox_firstName {
            self.textbox_lastName.becomeFirstResponder()
        } else if textField == self.textbox_lastName {
            self.textbox_email.becomeFirstResponder()
        } else if textField == self.textbox_email {
            self.textbox_pw.becomeFirstResponder()
        } else if textField == self.textbox_pw{
            self.textbox_pwConformation.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
}
