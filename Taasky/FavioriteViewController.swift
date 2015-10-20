//
//  PantryViewController.swift
//  KitchenSupport
//
//  Created by Darrell Shi on 10/11/15.
//  Copyright © 2015 Purdue University. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class FavoriteViewController: UICollectionViewController {
    let recipeController = RecipeController()
    var recipes = [Recipe]()
    var recipeIDs = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Register cell classes
        self.collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        self.prepareForRecipes()
    }
    
    func prepareForRecipes() {
        recipeIDs = recipeController.getFeaturedRecipes()!
        if let recipeIDs = recipeController.getFeaturedRecipes() {
            for recipeID in recipeIDs {
                if let recipe = recipeController.getRecipe(recipeID) {
                    recipes.append(recipe)
                }
            }
        }
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
        return recipes.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("pantryItemCell", forIndexPath: indexPath)
        
        let imageView = UIImageView.init()
        dispatch_async(dispatch_get_main_queue()) {
        imageView.image = self.recipes[indexPath.row].getImage()
        }
        imageView.contentMode = UIViewContentMode.ScaleAspectFill
        imageView.frame = CGRect(x: 0, y: 0, width: 150, height: 150)
        
        let backgroundLabel = UILabel.init(frame: CGRect(x: 0, y: 150, width: 150, height: 30))
        backgroundLabel.backgroundColor = UIColor(red: 208, green: 219, blue: 208, alpha: 1.0)
        
        let nameLabel = UILabel.init(frame: CGRect(x: 5, y: 150, width: 140, height: 30))
        nameLabel.text = recipes[indexPath.row].getName()
        nameLabel.textColor = UIColor.blackColor()
        nameLabel.font = UIFont(name: "Gill Sans", size: 12.0)
        nameLabel.textAlignment = NSTextAlignment.Left
        nameLabel.numberOfLines = 2
        
        cell.addSubview(imageView)
        cell.addSubview(backgroundLabel)
        cell.addSubview(nameLabel)
        
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
}
