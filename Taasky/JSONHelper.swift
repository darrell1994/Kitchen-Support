//
//  JSON.swift
//  KitchenSupport
//
//  Created by Darrell Shi on 10/16/15.
//  Copyright © 2015 Purdue University. All rights reserved.
//

import Foundation

class JSONHelper {
    func getJSON(urlToRequest: String) -> NSData{
        return NSData(contentsOfURL: NSURL(string: urlToRequest)!)!
    }
    
    func parseJSON(inputData: NSData) -> NSDictionary?{
        do {
            let boardsDictionary: NSDictionary = try NSJSONSerialization.JSONObjectWithData(inputData, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
            return boardsDictionary
            
        } catch {
            print("Error with NSJSONSerialization")
        }
        return nil
    }
}