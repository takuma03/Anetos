//
//  ChangeMailViewTableViewCell.swift
//  Anetos
//
//  Created by 齋藤卓馬 on 2017/04/30.
//  Copyright © 2017年 齋藤卓馬. All rights reserved.
//

import UIKit

//デリゲート先に適用してもらうプロトコル
protocol MailDelegate{
    func textFieldDidEndEditing(cell:ChangeMailViewTableViewCell, value:String)
}

class ChangeMailViewTableViewCell: UITableViewCell, UITextFieldDelegate {

    @IBOutlet weak var mailTextField: UITextField!
    
    var delegate:MailDelegate! = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        //テキストフィールドのデリゲート先を自分に設定する。
        mailTextField.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //デリゲートメソッド
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        //キーボードを閉じる。
        textField.resignFirstResponder()
        return true
    }
    
    //デリゲートメソッド
    func textFieldDidEndEditing(_ textField: UITextField) {
        //テキストフィールドから受けた通知をデリゲート先に流す。
        self.delegate.textFieldDidEndEditing(cell: self, value:mailTextField.text!)
    }
    
}
