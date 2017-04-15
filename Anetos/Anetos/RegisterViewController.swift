//
//  RegisterViewController.swift
//  Anetos
//
//  Created by 齋藤卓馬 on 2017/01/16.
//  Copyright © 2017年 齋藤卓馬. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,RegisterDelegate{
    
    @IBAction func unwindToRegister(segue: UIStoryboardSegue){
    }
    @IBOutlet weak var registerTableView: UITableView!
    //AppDelegateのインスタンスを取得
    var appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    // ActivityIndicator を用意
    var ActivityIndicator: UIActivityIndicatorView!
    
    //データ
    var dataList = [["ユーザー名"],["パスワード","パスワード(確認用)"],["メールアドレス","メールアドレス(確認用)"],["男性","女性"],["誕生日"],["お住まい"]]
    
    //セクション
    var sectionIndex:[String] = ["ユーザー名","パスワード","メールアドレス","性別","誕生日","お住まい"]
    
    //データを返すメソッド
    func tableView(_ tableView:UITableView, cellForRowAt indexPath:IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            //セルを取得して値を設定する。
            let cell = tableView.dequeueReusableCell(withIdentifier: "RegisterCell", for:indexPath as IndexPath) as! RegisterTableViewCell
            var register = dataList[indexPath.section]
            cell.registerTextField.placeholder = register[indexPath.row]
            //自作セルのデリゲート先に自分を設定する。
            cell.delegate = self
            return cell
        }else if indexPath.section == 1 {
            //セルを取得して値を設定する。
            let cell = tableView.dequeueReusableCell(withIdentifier: "RegisterCell", for:indexPath as IndexPath) as! RegisterTableViewCell
            var register = dataList[indexPath.section]
            cell.registerTextField.placeholder = register[indexPath.row]
            cell.registerTextField.isSecureTextEntry = true
            //自作セルのデリゲート先に自分を設定する。
            cell.delegate = self
            return cell
        }else if indexPath.section == 2 {
            //セルを取得して値を設定する。
            let cell = tableView.dequeueReusableCell(withIdentifier: "RegisterCell", for:indexPath as IndexPath) as! RegisterTableViewCell
            var register = dataList[indexPath.section]
            cell.registerTextField.placeholder = register[indexPath.row]
            //自作セルのデリゲート先に自分を設定する。
            cell.delegate = self
            return cell
        }else if indexPath.section == 3 {
            //セルを取得する。
            let cell = tableView.dequeueReusableCell(withIdentifier: "SexCell", for:indexPath) as UITableViewCell
            var test = dataList[indexPath.section]
            if indexPath.row == 0 {
                cell.accessoryType = .checkmark
            }
            cell.textLabel?.text = test[indexPath.row]
            cell.detailTextLabel?.text = ""
            return cell
        }else if indexPath.section == 4 {
            //セルを取得して値を設定する。
            let cell = tableView.dequeueReusableCell(withIdentifier: "BirthdayCell", for:indexPath as IndexPath) as UITableViewCell
            var register = dataList[indexPath.section]
            cell.textLabel?.text = register[indexPath.row]
            cell.detailTextLabel?.text = self.appDelegate.birthday
            cell.accessoryType = .disclosureIndicator
            return cell
        }else {
            //セルを取得して値を設定する。
            let cell = tableView.dequeueReusableCell(withIdentifier: "RegionCell", for:indexPath as IndexPath) as UITableViewCell
            var register = dataList[indexPath.section]
            cell.textLabel?.text = register[indexPath.row]
            cell.detailTextLabel?.text = self.appDelegate.region
            cell.accessoryType = .disclosureIndicator
            return cell
        }
    }
    
    // Cell が選択された場合
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 3 {
            if indexPath.row == 0 {
                //チェックマークを外す
                let nocell = IndexPath(item: 1, section: 3)
                let no_cell = tableView.cellForRow(at: nocell)
                no_cell?.accessoryType = .none
                
                // チェックマークを入れる
                let cell = tableView.cellForRow(at:indexPath)
                cell?.accessoryType = .checkmark
                //男性の場合は1を入れる
                self.appDelegate.sex = 1
            }else{
                //チェックマークを外す
                let nocell = IndexPath(item: 0, section: 3)
                let no_cell = tableView.cellForRow(at: nocell)
                no_cell?.accessoryType = .none
                
                // チェックマークを入れる
                let cell = tableView.cellForRow(at:indexPath)
                cell?.accessoryType = .checkmark
                //女性の場合は0を入れる
                self.appDelegate.sex = 0
            }
        }else if indexPath.section == 4 {
            performSegue(withIdentifier: "toRegisterBirthdayViewController",sender: nil)
        }else if indexPath.section == 5 {
            performSegue(withIdentifier: "toRegisterRegionViewController",sender: nil)
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
        let testXib = UINib(nibName:"RegisterTableViewCell", bundle:nil)
        registerTableView.register(testXib, forCellReuseIdentifier:"RegisterCell")

    }
    
    override func viewWillAppear(_ animated: Bool) {
        registerTableView.reloadData()
    }
    
    //デリゲートメソッド
    func textFieldDidEndEditing(cell: RegisterTableViewCell, value:String) {
        //変更されたセルのインデックスを取得する。
        let index = registerTableView.indexPathForRow(at: cell.convert(cell.bounds.origin, to:registerTableView))
        
        //データを変更する。
        let sec = index!.section
        let row = index!.row
        
        dataList[sec][row] = value
        print(value)
        print(dataList)
    }
    
    
    @IBAction func registerUser(_ sender: UIButton) {
        //TODO
        //入力チェック処理を追加
        
        
        //POSTするデータを設定する
        let postString = "user_name=\(dataList[0][0]) &password=\(dataList[1][0])&region=\(self.appDelegate.region)&email=\(dataList[2][0])&sex=\(self.appDelegate.sex)&birthday=\(self.appDelegate.birthday)"
        
        //グローバル変数にユーザ名を格納
        //URLを設定する
        var request = URLRequest(url: URL(string: "http://52.193.213.154:3000/api/v1/users/")!)
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
            let response_data: String = String(data: data!, encoding: .utf8)!
            print(response_data)
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
    
    
    //通信が完了した後に実行する関数
    func completionHandler1(){
        
        // バックグラウンドだとUIの処理が出来ないので、メインスレッドでUIの処理を行わせる.
        DispatchQueue.main.async {
            // クルクルストップ
            self.ActivityIndicator.stopAnimating()
            
            
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
