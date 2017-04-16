//
//  HomeCollectionViewCell.swift
//  Anetos
//
//  Created by 齋藤卓馬 on 2017/04/16.
//  Copyright © 2017年 齋藤卓馬. All rights reserved.
//

import UIKit
import SDWebImage


class HomeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var homeImageView: UIImageView!
    
    func setCell(cloth :Cloth) {
        
        homeImageView.sd_setImage(with: cloth.imageUrl as URL?)
        
        
    }
    
    
    
}
