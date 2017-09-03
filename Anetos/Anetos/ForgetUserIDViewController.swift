//
//  ForgetUserIDViewController.swift
//  Anetos
//
//  Created by 齋藤卓馬 on 2017/09/03.
//  Copyright © 2017年 齋藤卓馬. All rights reserved.
//

import UIKit

class ForgetUserIDViewController: UIViewController {
    
    @IBOutlet weak var messageLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        messageLabel.numberOfLines = 4
        messageLabel.text = "ユーザー IDをお忘れの方は登録されているメールアドレスを入力してください。ユーザーIDを登録されているメールアドレスに送信いたします。"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //ユーザーIDを忘れた際にメールを送信する処理
    @IBAction func sendMail(_ sender: UIButton) {
        
    }
    
}
