//
//  Model.swift
//  Anetos
//
//  Created by 齋藤卓馬 on 2017/02/22.
//  Copyright © 2017年 齋藤卓馬. All rights reserved.
//

import Foundation


class Cloth : NSObject {
    var imageUrl:NSURL?

    
    init(imageUrl: NSURL?){
        self.imageUrl = imageUrl
     
    }
}

class Cloth2 : NSObject {
    var imageUrl:NSURL?
    var id:String
    var tag:String
    var register_date:String
    
    init(imageUrl: NSURL?,id: String,tag: String,register_date: String){
        self.id = id
        self.imageUrl = imageUrl
        self.tag = tag
        self.register_date = register_date
    }
    
}











