//
//  EditCellViewController.swift
//  Anetos
//
//  Created by 齋藤卓馬 on 2017/02/26.
//  Copyright © 2017年 齋藤卓馬. All rights reserved.
//

import Foundation

class EditCellViewController: UIViewController {
    
    @IBOutlet weak var selectCloth: UIImageView!
    var selectedID: String!
    
    //TODO
    //削除ボタンを押下したときの処理
    @IBAction func deleteCloth(_ sender: Any) {
        print("削除しました。")
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        selectCloth.sd_setImage(with: URL(string: "http://52.196.123.118:3000/clothes/get_image?id=" + selectedID))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
