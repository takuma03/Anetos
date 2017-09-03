//
//  ForgetPasswordViewController.swift
//  Anetos
//
//  Created by 齋藤卓馬 on 2017/09/03.
//  Copyright © 2017年 齋藤卓馬. All rights reserved.
//

import UIKit

class ForgetPasswordViewController: UIViewController {
    
    @IBOutlet weak var messageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        messageLabel.numberOfLines = 4
        messageLabel.text = "パスワードをお忘れの方は登録されているメールアドレスを入力してください。登録されているメールアドレスにパスワード変更用の情報を送信いたします。"
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //パスワードを忘れた際にメールアドレスを送信する処理
    @IBAction func sendMail(_ sender: UIButton) {
        
    }
 
}
