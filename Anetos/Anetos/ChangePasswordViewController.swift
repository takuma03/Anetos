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
    
    // ActivityIndicator を用意
    var ActivityIndicator: UIActivityIndicatorView!
    
    //AppDelegateのインスタンスを取得
    var appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    //レスポンスデータ
    var response_data: String!
    
    //データ
    var dataList = [["現在のパスワード"],["新しいパスワード","新しいパスワード(確認用)"]]
    
    //セクション
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
        //キーボードを閉じる 
        self.view.endEditing(true)
        if dataList[0][0].contains("現在のパスワード") || dataList[0][0].isEmpty {
            print("現在のパスワードが入力されていません。")
            // ① UIAlertControllerクラスのインスタンスを生成
            // タイトル, メッセージ, Alertのスタイルを指定する
            // 第3引数のpreferredStyleでアラートの表示スタイルを指定する
            let alert: UIAlertController = UIAlertController(title: "エラー", message: "現在のパスワードが入力されていません。", preferredStyle:  UIAlertControllerStyle.alert)
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
        }else if dataList[1][0].contains("新しいパスワード") || dataList[1][0].isEmpty {
            print("新しいパスワードが入力されていません。")
            // ① UIAlertControllerクラスのインスタンスを生成
            // タイトル, メッセージ, Alertのスタイルを指定する
            // 第3引数のpreferredStyleでアラートの表示スタイルを指定する
            let alert: UIAlertController = UIAlertController(title: "エラー", message: "新しいパスワードが入力されていません。", preferredStyle:  UIAlertControllerStyle.alert)
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
        }else if dataList[1][1].contains("新しいパスワード(確認用)") || dataList[1][1].isEmpty {
            print("新しいパスワード(確認用)が入力されていません。")
            // ① UIAlertControllerクラスのインスタンスを生成
            // タイトル, メッセージ, Alertのスタイルを指定する
            // 第3引数のpreferredStyleでアラートの表示スタイルを指定する
            let alert: UIAlertController = UIAlertController(title: "エラー", message: "新しいパスワード(確認用)が入力されていません。", preferredStyle:  UIAlertControllerStyle.alert)
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
        }else if dataList[1][0] != dataList[1][1]{
            print("新しいパスワードが一致していません。")
            // ① UIAlertControllerクラスのインスタンスを生成
            // タイトル, メッセージ, Alertのスタイルを指定する
            // 第3引数のpreferredStyleでアラートの表示スタイルを指定する
            let alert: UIAlertController = UIAlertController(title: "エラー", message: "新しいパスワードが一致していません。", preferredStyle:  UIAlertControllerStyle.alert)
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
        }else{
            //POSTするデータを設定する
            let postString = "user_name=\(self.appDelegate.user_name)&current_password=\(dataList[0][0])&changed_password=\(dataList[1][0])"
            
            //URLを設定する
            var request = URLRequest(url: URL(string: "http://52.193.213.154:3000/api/v1/password/")!)
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
                self.response_data = data
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
        
    }
    
    func completionHandler1(){
        
        DispatchQueue.main.async {
            // クルクルストップ
            self.ActivityIndicator.stopAnimating()
            print(self.response_data)
            if self.response_data.contains("エラー") {
                // ① UIAlertControllerクラスのインスタンスを生成
                // タイトル, メッセージ, Alertのスタイルを指定する
                // 第3引数のpreferredStyleでアラートの表示スタイルを指定する
                let alert: UIAlertController = UIAlertController(title: "エラー", message: "現在のパスワードが誤っています。", preferredStyle:  UIAlertControllerStyle.alert)
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

            }else{
                // ① UIAlertControllerクラスのインスタンスを生成
                // タイトル, メッセージ, Alertのスタイルを指定する
                // 第3引数のpreferredStyleでアラートの表示スタイルを指定する
                let alert: UIAlertController = UIAlertController(title: "完了", message: "パスワードを変更しました。", preferredStyle:  UIAlertControllerStyle.alert)
                // ② Actionの設定
                // Action初期化時にタイトル, スタイル, 押された時に実行されるハンドラを指定する
                // 第3引数のUIAlertActionStyleでボタンのスタイルを指定する
                // OKボタン
                let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:{
                    // ボタンが押された時の処理を書く（クロージャ実装）
                    (action: UIAlertAction!) -> Void in
                    let storyboard: UIStoryboard = self.storyboard!
                    let nextView = storyboard.instantiateViewController(withIdentifier: "Setting")
                    self.present(nextView, animated: true, completion: nil)
                    print("OK")
                })
                // ③ UIAlertControllerにActionを追加
                alert.addAction(defaultAction)
                // ④ Alertを表示
                self.present(alert, animated: true, completion: nil)
            }
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

