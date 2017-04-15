//
//  RegisterBirthdayViewController.swift
//  Anetos
//
//  Created by 齋藤卓馬 on 2017/04/09.
//  Copyright © 2017年 齋藤卓馬. All rights reserved.
//

import UIKit

class RegisterBirthdayViewController: UIViewController {
    
    //AppDelegateのインスタンスを取得
    var appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var registerBirthday: String = ""
    
    @IBAction func registerBirthday(_ sender: UIButton) {
        self.appDelegate.birthday = registerBirthday
        print(self.appDelegate.birthday)
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func setBirthday(_ sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        
        registerBirthday = formatter.string(from: sender.date)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
