//
//  ChangePasswordTableViewCell.swift
//  Anetos
//
//  Created by 齋藤卓馬 on 2017/03/27.
//  Copyright © 2017年 齋藤卓馬. All rights reserved.
//

import UIKit

//デリゲート先に適用してもらうプロトコル
protocol PasswordDelegate {
    func textFieldDidEndEditing(cell:ChangePasswordTableViewCell, value:String)
}

class ChangePasswordTableViewCell: UITableViewCell, UITextFieldDelegate {

    @IBOutlet weak var passwordTextField: UITextField!
    
    var delegate:PasswordDelegate! = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        //テキストフィールドのデリゲート先を自分に設定する。
        passwordTextField.delegate = self
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
        self.delegate.textFieldDidEndEditing(cell: self, value:passwordTextField.text!)
    }
    
}
