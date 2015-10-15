//
//  Ingredient.swift
//  KitchenSupport
//
//  Created by Darrell Shi on 10/13/15.
//  Copyright © 2015 Purdue University. All rights reserved.
//

import Foundation
import UIKit

class Ingredient {
    var name: String
    var image: UIImage
    
    init(name: String, image: UIImage) {
        self.name = name
        self.image = image
    }
    
    func getName()->String {
        return name
    }
    
    func getImage()->UIImage {
        return image
    }
    
}