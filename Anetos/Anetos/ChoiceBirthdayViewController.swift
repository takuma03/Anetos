//
//  ChoiceBirthdayViewController.swift
//  Anetos
//
//  Created by 齋藤卓馬 on 2017/03/20.
//  Copyright © 2017年 齋藤卓馬. All rights reserved.
//

import UIKit

class ChoiceBirthdayViewController: UIViewController {

    
    //AppDelegateのインスタンスを取得
    var appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var changedBirthday: String = ""
    
    @IBAction func changeBirthday(_ sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        
        changedBirthday = formatter.string(from: sender.date)
    }
    @IBAction func setBirthday(_ sender: UIButton) {
        self.appDelegate.birthday = changedBirthday
        print(self.appDelegate.birthday)
        self.dismiss(animated: true, completion: nil)
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
