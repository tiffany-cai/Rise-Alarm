//
//  Quote.swift
//  RiseAlarm
//
//  Created by Tiffany Cai on 5/17/20.
//  Copyright © 2020 Tiffany Cai. All rights reserved.
//

import Foundation

struct Quote: Codable {

    let _id: String
    let content: String
    let author: String
    let length: Int
    let tags: [String]
    
}
    

/*
 
 {
 
 "_id":"2OVqy9KVYy3m",
 
 "tags":["famous-quotes"],
 
 "content":"No one saves us but ourselves. No one can and no one may. We ourselves must walk the path.",

 "author":"Buddha",
 
 "length":90
 
 }
 
 
 
 */
