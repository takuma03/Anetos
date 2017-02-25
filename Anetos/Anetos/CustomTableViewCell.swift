//
//  CustomTableViewCell.swift
//  Anetos
//
//  Created by 齋藤卓馬 on 2017/02/22.
//  Copyright © 2017年 齋藤卓馬. All rights reserved.
//

import UIKit
import SDWebImage

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var clothImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCell(cloth :Cloth) {
//        do{
//            let imageData :NSData = try NSData(contentsOf: cloth.imageUrl! as URL,options: NSData.ReadingOptions.mappedIfSafe)
//            self.clothImage.image = UIImage(data:imageData as Data)
//        }catch{
//            
//        }
        clothImage.sd_setImage(with: cloth.imageUrl as URL?)
        
        
    }

}
