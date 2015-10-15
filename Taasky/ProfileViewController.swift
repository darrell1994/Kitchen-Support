//
//  ViewController.swift
//  Kitchen.Support
//
//  Created by Darrell Shi on 9/29/15.
//  Copyright © 2015 Darrell Shi. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    @IBOutlet weak var profileImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileImage.image = UIImage(named: "mitchdanielstop.jpg")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signOutClicked(sender: AnyObject) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("loginViewController")
        presentViewController(vc, animated: true, completion: nil)
    }
    
}

