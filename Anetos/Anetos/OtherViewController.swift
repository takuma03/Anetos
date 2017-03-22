//
//  OtherViewController.swift
//  Anetos
//
//  Created by 齋藤卓馬 on 2017/03/02.
//  Copyright © 2017年 齋藤卓馬. All rights reserved.
//

import UIKit

class OtherViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    @IBAction func unwindToOther(segue: UIStoryboardSegue){
        
    }
    
    var selectedCell: [String]?
    
    //データ
    var dataInSection = [["設定","FAQ","使い方ガイド","ご意見・お問い合わせ","Anetosについて"]]
    //セクション
    var sectionIndex:[String] = [""]
    //データを返す
    func tableView(_ tableView:UITableView, cellForRowAt indexPath:IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OtherCell", for:indexPath as IndexPath) as UITableViewCell
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
            performSegue(withIdentifier: "toSettingViewController",sender: nil)
        }else if indexPath.row == 1{
            performSegue(withIdentifier: "toFAQViewController",sender: nil)
        }else if indexPath.row == 2{
            performSegue(withIdentifier: "toGuideViewController",sender: nil)
        }else if indexPath.row == 3{
            if let url = URL(string: "https://twitter.com/anetos_support"), UIApplication.shared.canOpenURL(url){
                UIApplication.shared.open(url, options: [:])
            }
        }else if indexPath.row == 4{
            performSegue(withIdentifier: "toAboutViewController",sender: nil)
        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
