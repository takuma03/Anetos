//
//  RegisterTableViewCell.swift
//  Anetos
//
//  Created by 齋藤卓馬 on 2017/04/08.
//  Copyright © 2017年 齋藤卓馬. All rights reserved.
//

import UIKit


//デリゲート先に適用してもらうプロトコル
protocol RegisterDelegate {
    func textFieldDidEndEditing(cell:RegisterTableViewCell, value:String)
}

class RegisterTableViewCell: UITableViewCell, UITextFieldDelegate {
    
    
    @IBAction func unwindToRegister(segue: UIStoryboardSegue){
        
    }
    
    @IBOutlet weak var registerTextField: UITextField!
    
    var delegate:RegisterDelegate! = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        //テキストフィールドのデリゲート先を自分に設定する。
        registerTextField.delegate = self
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
        self.delegate.textFieldDidEndEditing(cell: self, value: registerTextField.text!)
    }
    
    
}
