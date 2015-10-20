//
//  Recipe.swift
//  KitchenSupport
//
//  Created by Darrell Shi on 10/13/15.
//  Copyright © 2015 Purdue University. All rights reserved.
//

import Foundation
import UIKit

class Recipe {
    private var name: String
    private var image: UIImage
    private var rating: Int
    private var prepTime: Int // in minutes
    
    init(name: String, image: UIImage, rating: Int, prepTime: Int) {
        self.name = name
        self.image = image
        self.rating = rating
        self.prepTime = prepTime
    }
    
    func getName()->String {
        return name
    }
    
    func getImage()->UIImage {
        return image
    }
    
    func getRating()->Int {
        return rating
    }
    
    func getPrepTime()->Int {
        return prepTime
    }
}