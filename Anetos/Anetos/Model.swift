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
