//
//  SettingViewController.swift
//  Anetos
//
//  Created by 齋藤卓馬 on 2017/03/02.
//  Copyright © 2017年 齋藤卓馬. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController,UITableViewDelegate, UITableViewDataSource  {
    
    @IBAction func unwindToSetting(segue: UIStoryboardSegue){
        
    }

    var selectedCell: [String]?
    
    //データ
    var dataInSection = [["ユーザー情報の変更","パスワードの変更","メールアドレスの変更"]]
    //セクション
    var sectionIndex:[String] = [""]
    //データを返す
    func tableView(_ tableView:UITableView, cellForRowAt indexPath:IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingCell", for:indexPath as IndexPath) as UITableViewCell
        var test = dataInSection[indexPath.section]
        cell.textLabel?.text = test[indexPath.row]
        //print(indexPath.row)
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
        
        print(indexPath.row)
        if indexPath.row == 0 {
            // SettingViewController へ遷移するために Segue を呼び出す
            performSegue(withIdentifier: "toChangeUserViewController",sender: nil)
        }else if indexPath.row == 1{
            performSegue(withIdentifier: "toChangePasswordViewController",sender: nil)
        }else if indexPath.row == 2{
            performSegue(withIdentifier: "toChangeMailViewController",sender: nil)
        }
        
        
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
