//
//  ChangePasswordViewController.swift
//  Anetos
//
//  Created by 齋藤卓馬 on 2017/03/11.
//  Copyright © 2017年 齋藤卓馬. All rights reserved.
//

import UIKit

class ChangePasswordViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    //データ
    var dataInSection = [["現在のパスワード"],["新しいパスワード","パスワードを確認"]]
    //セクション
    var sectionIndex:[String] = ["",""]
    
    //データを返す
    func tableView(_ tableView:UITableView, cellForRowAt indexPath:IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PasswordCell", for:indexPath as IndexPath) as! ChangePasswordTableViewCell
        var section = dataInSection[indexPath.section]
        cell.textLabel?.text = section[indexPath.row]
        return cell
    }
    
    //データの個数を返す
    func tableView(_ tableView:UITableView, numberOfRowsInSection section:Int) -> Int {
        return dataInSection[section].count
    }
    
    //セクション名を返す
    func tableView(_ tableView:UITableView, titleForHeaderInSection section:Int) -> String?{
        return sectionIndex[section]
    }
    
    //セクションの個数を返す
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionIndex.count
    }
    
    // Cell が選択された場合
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PasswordCell", for:indexPath as IndexPath) as! ChangePasswordTableViewCell
        cell.becomeFirstResponder()
        
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
