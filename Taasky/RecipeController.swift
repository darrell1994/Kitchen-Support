//
//  RecipeController.swift
//  KitchenSupport
//
//  Created by Darrell Shi on 10/16/15.
//  Copyright © 2015 Purdue University. All rights reserved.
//

import Foundation
import UIKit

class RecipeController {
    func getFeaturedRecipes()->[String]? {
        let JSON = JSONHelper()
        let data = JSON.parseJSON(JSON.getJSON("http://api.kitchen.support/recipes/featured"))
        if (data!.valueForKey("status"))! as! String == "success" {
            let ids = data?.valueForKeyPath("data.matches.id") as! [String]
            return ids
        } else {
            return nil
        }
    }
    
    func getRecipe(id: String)->Recipe? {
        let JSON = JSONHelper()
        let data = JSON.parseJSON(JSON.getJSON("http://api.kitchen.support/recipes/recipe/\(id)"))
        if (data?.valueForKey("status"))! as! String == "success" {
            let name = data?.valueForKeyPath("data.name") as! String
            let imageURLArray = data?.valueForKeyPath("data.images.hostedLargeUrl") as! [String]
            let imageURL = imageURLArray[0]
            let image = UIImage(data: NSData(contentsOfURL: NSURL(string: imageURL)!)!)!
            let rating = data?.valueForKeyPath("data.rating") as! Int
            let time = data?.valueForKeyPath("data.totalTimeInSeconds") as! Int / 60
            let recipe = Recipe(name: name, image: image, rating: rating, prepTime: time)
            return recipe
        } else {
            return nil
        }
    }
}