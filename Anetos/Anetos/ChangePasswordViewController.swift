//
//  ChangePasswordViewController.swift
//  Anetos
//
//  Created by 齋藤卓馬 on 2017/03/11.
//  Copyright © 2017年 齋藤卓馬. All rights reserved.
//

import UIKit

class ChangePasswordViewController: UIViewController,UITableViewDataSource, PasswordDelegate {
    
    @IBOutlet weak var passwordTableView: UITableView!
    
    //データ
    var dataList = ["現在のパスワード","新しいパスワード","新しいパスワード(確認)"]
    
    //データを返すメソッド
    func tableView(_ tableView:UITableView, cellForRowAt indexPath:IndexPath) -> UITableViewCell {
        
        //セルを取得して値を設定する。
        let cell = tableView.dequeueReusableCell(withIdentifier: "TestCell", for:indexPath as IndexPath) as! ChangePasswordTableViewCell
        cell.passwordTextField.placeholder = dataList[indexPath.row]
        //自作セルのデリゲート先に自分を設定する。
        cell.delegate = self
        
        return cell
    }
    
    //データの個数を返すメソッド
    func tableView(_ tableView:UITableView, numberOfRowsInSection section:Int) -> Int {
        return dataList.count
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //自作セルをテーブルビューに登録する。
        let testXib = UINib(nibName:"ChangePasswordTableViewCell", bundle:nil)
        passwordTableView.register(testXib, forCellReuseIdentifier:"TestCell")
        
    }
    
    //デリゲートメソッド
    func textFieldDidEndEditing(cell: ChangePasswordTableViewCell, value:String) {
        //変更されたセルのインデックスを取得する。
        let index = passwordTableView.indexPathForRow(at: cell.convert(cell.bounds.origin, to:passwordTableView))
        
        //データを変更する。
        dataList[index!.row] = value
        print(dataList)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

