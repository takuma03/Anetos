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
    var dataList = [["現在のパスワード"],["新しいパスワード","新しいパスワード(確認用)"]]
    
    //セクション
    var dataList2 = [["","",""]]
    var sectionIndex:[String] = ["",""]
    
    //データを返すメソッド
    func tableView(_ tableView:UITableView, cellForRowAt indexPath:IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            //セルを取得して値を設定する。
            let cell = tableView.dequeueReusableCell(withIdentifier: "TestCell", for:indexPath as IndexPath) as! ChangePasswordTableViewCell
            var password = dataList[indexPath.section]
            cell.passwordTextField.placeholder = password[indexPath.row]
            //自作セルのデリゲート先に自分を設定する。
            cell.delegate = self
            return cell
        }else{
            //セルを取得して値を設定する。
            let cell = tableView.dequeueReusableCell(withIdentifier: "TestCell", for:indexPath as IndexPath) as! ChangePasswordTableViewCell
            var password = dataList[indexPath.section]
            cell.passwordTextField.placeholder = password[indexPath.row]
            //自作セルのデリゲート先に自分を設定する。
            cell.delegate = self
            return cell
        }
        
    }
    
    //データの個数を返すメソッド
    func tableView(_ tableView:UITableView, numberOfRowsInSection section:Int) -> Int {
        return dataList[section].count
    }
    
    //セクション名を返す
    func tableView(_ tableView:UITableView, titleForHeaderInSection section:Int) -> String?{
        return sectionIndex[section]
    }
    
    //セクションの個数を返す
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionIndex.count
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
        let sec = index!.section
        let row = index!.row
        
        dataList[sec][row] = value
        print(value)
        print(dataList)
    }
    
    @IBAction func changePassword(_ sender: Any) {
        
        
        if dataList[0][0].contains("現在のパスワード"){
            print("現在のパスワードが入力されていません。")
        }else if dataList[1][0].contains("新しいパスワード"){
            print("新しいパスワードが入力されていません。")
        }else if dataList[1][1].contains("新しいパスワード(確認用)"){
            print("新しいパスワード(確認用)が入力されていません。")
        }else if dataList[1][0] != dataList[1][1]{
            print("新しいパスワードが一致していません。")
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

