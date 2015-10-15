//
//  PantryViewController.swift
//  KitchenSupport
//
//  Created by Darrell Shi on 10/11/15.
//  Copyright © 2015 Purdue University. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class PantryViewController: UICollectionViewController {
    var ingredients: [Ingredient] = [Ingredient]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Register cell classes
        self.collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        tempInitIngredients()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return ingredients.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("pantryItemCell", forIndexPath: indexPath)
        
        let imageView = UIImageView.init()
        imageView.image = ingredients[indexPath.row].getImage()
        imageView.frame = CGRect(x: 0, y: 0, width: 150, height: 120)
        let backgroundLabel = UILabel.init(frame: CGRect(x: 0, y: 100, width: 150, height: 20))
        backgroundLabel.backgroundColor = UIColor.whiteColor()
        backgroundLabel.alpha = 0.70
        
        let label = UILabel.init(frame: CGRect(x: 0, y: 100, width: 150, height: 20))
        label.text = ingredients[indexPath.row].getName()
        label.textColor = UIColor.blackColor()
        label.font = UIFont(name: "Gill Sans", size: 14.0)
        label.textAlignment = NSTextAlignment.Center
        cell.addSubview(imageView)
        cell.addSubview(backgroundLabel)
        cell.addSubview(label)
        
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
            switch kind {
            case UICollectionElementKindSectionHeader:
                let headerView = collectionView.dequeueReusableSupplementaryViewOfKind(kind,
                    withReuseIdentifier: "pantryFooterView", forIndexPath: indexPath)
                    as! PantryHeaderView
                return headerView
            default:
                assert(false, "Unexpected element kind")
            }
    }
    
    func tempInitIngredients() {
        let pantryCellImages = ["bbq sauce.jpg", "broccoli.jpg", "eggs.jpg", "milk.jpg", "oil.jpg", "pepperoni.jpg", "lettuce.jpg", "peppers.jpg", "rice.jpg", "salt.jpg"]
        for i in 0...9 {
            let index: String.Index = pantryCellImages[i].characters.indexOf(".")!
            let itemName = pantryCellImages[i].substringToIndex(index)
            self.ingredients.append(Ingredient(name: itemName, image: UIImage(named: pantryCellImages[i])!))
        }
    }
    
    // MARK: UICollectionViewDelegate
    
    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
    return true
    }
    */
    
    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
    return true
    }
    */
    
    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
    return false
    }
    
    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
    return false
    }
    
    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */
    
}
