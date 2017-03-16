//
//  ChangeUserViewController.swift
//  Anetos
//
//  Created by 齋藤卓馬 on 2017/03/11.
//  Copyright © 2017年 齋藤卓馬. All rights reserved.
//

import UIKit

class ChangeUserViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    var selectedCell: [String]?
    
    //データ
    var dataInSection = [["男性","女性"],["誕生日","都道府県"]]
    //セクション
    var sectionIndex:[String] = ["",""]
    //データを返す
    func tableView(_ tableView:UITableView, cellForRowAt indexPath:IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for:indexPath as IndexPath) as UITableViewCell
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
        print(indexPath.section)
        print(indexPath.row)
        
        
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                //チェックマークを外す
                let nocell = IndexPath(item: 1, section: 0)
                let no_cell = tableView.cellForRow(at: nocell)
                no_cell?.accessoryType = .none
                
                // チェックマークを入れる
                let cell = tableView.cellForRow(at:indexPath)
                cell?.accessoryType = .checkmark
                
                
            }else{
                //チェックマークを外す
                let nocell = IndexPath(item: 0, section: 0)
                let no_cell = tableView.cellForRow(at: nocell)
                no_cell?.accessoryType = .none
                
                // チェックマークを入れる
                let cell = tableView.cellForRow(at:indexPath)
                cell?.accessoryType = .checkmark
            }
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
