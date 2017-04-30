//
//  ChangeMailViewController.swift
//  Anetos
//
//  Created by 齋藤卓馬 on 2017/03/11.
//  Copyright © 2017年 齋藤卓馬. All rights reserved.
//

class ChangeMailViewController: UIViewController,UITableViewDataSource, MailDelegate {
    
    @IBOutlet weak var changeMailTableView: UITableView!
    //AppDelegateのインスタンスを取得
    var appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    //レスポンスデータ
    var response_data: String!
    
    //データ
    var dataList = [["現在のメールアドレス"],["新しいメールアドレス","新しいメールアドレス(確認用)"]]
    
    //セクション
    var sectionIndex:[String] = ["",""]
    
    //データを返すメソッド
    func tableView(_ tableView:UITableView, cellForRowAt indexPath:IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            //セルを取得して値を設定する。
            let cell = tableView.dequeueReusableCell(withIdentifier: "TestCell", for:indexPath as IndexPath) as! ChangeMailViewTableViewCell
            var password = dataList[indexPath.section]
            cell.mailTextField.placeholder = password[indexPath.row]
            //自作セルのデリゲート先に自分を設定する。
            cell.delegate = self
            return cell
        }else{
            //セルを取得して値を設定する。
            let cell = tableView.dequeueReusableCell(withIdentifier: "TestCell", for:indexPath as IndexPath) as! ChangeMailViewTableViewCell
            var password = dataList[indexPath.section]
            cell.mailTextField.placeholder = password[indexPath.row]
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
        let testXib = UINib(nibName:"ChangeMailViewTableViewCell", bundle:nil)
        changeMailTableView.register(testXib, forCellReuseIdentifier:"TestCell")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //デリゲートメソッド
    func textFieldDidEndEditing(cell: ChangeMailViewTableViewCell, value:String) {
        //変更されたセルのインデックスを取得する。
        let index = changeMailTableView.indexPathForRow(at: cell.convert(cell.bounds.origin, to:changeMailTableView))
        
        //データを変更する。
        let sec = index!.section
        let row = index!.row
        
        dataList[sec][row] = value
        print(value)
        print(dataList)
    }
    
    
}
