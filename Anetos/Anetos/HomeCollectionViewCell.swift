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
    @IBOutlet weak var OthersImageView: UIImageView!

    func setCell(cloth :Cloth) {
        
        homeImageView.sd_setImage(with: cloth.imageUrl as URL?)
        
    }
    
    func setCell2(cloth :Cloth) {

        OthersImageView.sd_setImage(with: cloth.imageUrl as URL?)
    
    }
}
