//
//  ChangeUserViewController.swift
//  Anetos
//
//  Created by 齋藤卓馬 on 2017/03/11.
//  Copyright © 2017年 齋藤卓馬. All rights reserved.
//

import UIKit

class ChangeUserViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    @IBAction func unwindToChangeUser(segue: UIStoryboardSegue){
        
    }
    // ActivityIndicator を用意
    var ActivityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var userTable: UITableView!
    
    //AppDelegateのインスタンスを取得
    var appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    var selectedCell: [String]?
    //データ
    var dataInSection = [["男性","女性"],["誕生日","都道府県"]]
    //セクション
    var sectionIndex:[String] = ["",""]
    //データを返す
    func tableView(_ tableView:UITableView, cellForRowAt indexPath:IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for:indexPath as IndexPath) as UITableViewCell
            cell.detailTextLabel?.text = ""
            var test = dataInSection[indexPath.section]
            if self.appDelegate.sex == 1 {
                if indexPath.row == 0 {
                    cell.accessoryType = .checkmark
                }
            }else{
                if indexPath.row == 1 {
                    cell.accessoryType = .checkmark
                }
            }
            cell.textLabel?.text = test[indexPath.row]
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for:indexPath as IndexPath) as UITableViewCell
            cell.detailTextLabel?.text = ""
            var test = dataInSection[indexPath.section]
            cell.textLabel?.text = test[indexPath.row]
            if indexPath.row == 0{
                // 詳細テキストラベル
                cell.detailTextLabel?.text = self.appDelegate.birthday
            }else{
                cell.detailTextLabel?.text = self.appDelegate.region
            }
            
            cell.accessoryType = .disclosureIndicator
            
            return cell
            //リロードを追加
        }
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
                //男性の場合は1を入れる
                self.appDelegate.sex = 1
                
            }else{
                //チェックマークを外す
                let nocell = IndexPath(item: 0, section: 0)
                let no_cell = tableView.cellForRow(at: nocell)
                no_cell?.accessoryType = .none
                
                // チェックマークを入れる
                let cell = tableView.cellForRow(at:indexPath)
                cell?.accessoryType = .checkmark
                //女性の場合は0を入れる
                self.appDelegate.sex = 0
            }
        }else{
            if indexPath.row == 0 {
                performSegue(withIdentifier: "toChoiceBirthdayViewController",sender: nil)
            }else{
                performSegue(withIdentifier: "toChoiceRegionsViewController",sender: nil)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        userTable.reloadData()
        
    }
    
    @IBAction func updateUser(_ sender: UIButton) {
        //POSTするデータを設定する
        let postString = "user_name=\(self.appDelegate.user_name)&sex=\(self.appDelegate.sex)&birthday=\(self.appDelegate.birthday)&region_name=\(self.appDelegate.region)"
        
        //URLを設定する
        var request = URLRequest(url: URL(string: "http://52.193.213.154:3000/api/v1/user_update/")!)
        //HTTPメソッドを設定する
        request.httpMethod = "POST"
        //HTTPBodyにデータを設定する
        request.httpBody = postString.data(using: .utf8)
        //タスクを作成する
        let task = URLSession.shared.dataTask(with: request, completionHandler: {
            (data, response, error) in
            
            if error != nil {
                print(error!)
                return
            }
            
            print("response: \(response!)")
            //取得したtokenに余分な文字列が含まれているため削除して変数に格納
            let data: String = String(data: data!, encoding: .utf8)!
            print(data)
            self.completionHandler1()
            
        })
        // ActivityIndicatorを作成＆中央に配置
        ActivityIndicator = UIActivityIndicatorView()
        ActivityIndicator.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        ActivityIndicator.center = self.view.center
        
        // クルクルをストップした時に非表示する
        ActivityIndicator.hidesWhenStopped = true
        
        // 色を設定
        ActivityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        
        //Viewに追加
        self.view.addSubview(ActivityIndicator)
        // クルクルスタート
        ActivityIndicator.startAnimating()
        
        //タスクを開始する
        task.resume()
        
        
    }
    
    func completionHandler1(){
        // クルクルストップ
        ActivityIndicator.stopAnimating()
        // バックグラウンドだとUIの処理が出来ないので、メインスレッドでUIの処理を行わせる.
        DispatchQueue.main.async {
            // ① UIAlertControllerクラスのインスタンスを生成
            // タイトル, メッセージ, Alertのスタイルを指定する
            // 第3引数のpreferredStyleでアラートの表示スタイルを指定する
            let alert: UIAlertController = UIAlertController(title: "保存完了", message: "更新しました。", preferredStyle:  UIAlertControllerStyle.alert)
            // ② Actionの設定
            // Action初期化時にタイトル, スタイル, 押された時に実行されるハンドラを指定する
            // 第3引数のUIAlertActionStyleでボタンのスタイルを指定する
            // OKボタン
            let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:{
                // ボタンが押された時の処理を書く（クロージャ実装）
                (action: UIAlertAction!) -> Void in
                print("OK")
            })
            // ③ UIAlertControllerにActionを追加
            alert.addAction(defaultAction)
            // ④ Alertを表示
            self.present(alert, animated: true, completion: nil)
        }
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
