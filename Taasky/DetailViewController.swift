//
//  DetailViewController.swift
//  Taasky
//
//  Created by Audrey M Tam on 18/03/2015.
//  Copyright (c) 2015 Ray Wenderlich. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
  var hamburgerView: HamburgerView?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Remove the drop shadow from the navigation bar
    navigationController!.navigationBar.clipsToBounds = true
    
    let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: "hamburgerViewTapped")
    hamburgerView = HamburgerView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
    hamburgerView!.addGestureRecognizer(tapGestureRecognizer)
    navigationItem.leftBarButtonItem = UIBarButtonItem(customView: hamburgerView!)
  }
  
  func hamburgerViewTapped() {
    let navigationController = parentViewController as! UINavigationController
    let containerViewController = navigationController.parentViewController as! ContainerViewController
    containerViewController.hideOrShowMenu(!containerViewController.showingMenu, animated: true)
  }
  
  var menuItem: NSDictionary? {
    didSet {
      if let newMenuItem = menuItem {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier(newMenuItem["title"] as! String)
        vc.view.frame = self.view.bounds
        vc.view.backgroundColor = UIColor(colorArray: newMenuItem["colors"] as! NSArray)
        self.view.addSubview(vc.view)
        self.addChildViewController(vc)
        vc.didMoveToParentViewController(self)
        
        navigationItem.title = newMenuItem["title"] as? String
      }
    }
  }
}
