//
//  LoginViewController.swift
//  Anetos
//
//  Created by 齋藤卓馬 on 2017/01/16.
//  Copyright © 2017年 齋藤卓馬. All rights reserved.
//

import UIKit
import SwiftyJSON

class LoginViewController: UIViewController,UITextFieldDelegate {
    
    var region_id: String = ""
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        username.delegate = self
        password.delegate = self
    }
    
    func textFieldShouldReturn(_ username: UITextField) -> Bool {
        // 今フォーカスが当たっているテキストボックスからフォーカスを外す
        username.resignFirstResponder()
        switch username.tag{
        // Tag番号が1の場合は次のテキストボックスをフォーカスする
        case 1:
            let nextTag = username.tag + 1
            if let nextTextField = self.view.viewWithTag(nextTag) {
                nextTextField.becomeFirstResponder()
            }
        // Tag番号が1以外の場合はログインを実行する
        default:
            login(Any.self)
        }
        return true
    }

    
    // ActivityIndicator を用意
    var ActivityIndicator: UIActivityIndicatorView!
    
    //AppDelegateのインスタンスを取得
    var appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBAction func login(_ sender: Any) {
        //POSTするデータを設定する
        let postString = "user_name=\(username.text!)&password=\(password.text!)"
        //グローバル変数にユーザ名を格納
        self.appDelegate.user_name =  username.text!
        //URLを設定する
        var request = URLRequest(url: URL(string: "http://52.193.213.154:3000/api/v1/login/")!)
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
            let token_data: String = String(data: data!, encoding: .utf8)!
            print("token_data")
            let dataToConvert = token_data.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
            let json = JSON(data: dataToConvert!)
            print(json["message"])
            print(json["token"])
            self.appDelegate.token = json["token"].stringValue
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
            print("data: \(self.appDelegate.token)")
            // クルクルストップ
            self.ActivityIndicator.stopAnimating()
            if (self.appDelegate.token.isEmpty) {
                //ログインエラー処理
                // ① UIAlertControllerクラスのインスタンスを生成
                // タイトル, メッセージ, Alertのスタイルを指定する
                // 第3引数のpreferredStyleでアラートの表示スタイルを指定する
                let alert: UIAlertController = UIAlertController(title: "ログインエラー", message: "ユーザー名またはパスワードが誤っております。", preferredStyle:  UIAlertControllerStyle.alert)
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
                
            } else {
                
                var request = URLRequest(url: URL(string: "http://52.193.213.154:3000/api/v1/clothes/" + self.appDelegate.user_name)!)
                //HTTPメソッドを設定する
                request.httpMethod = "GET"
                
                //タスクを作成する
                let task = URLSession.shared.dataTask(with: request, completionHandler: {
                    (data, response, error) in
                    
                    if error != nil {
                        print(error!)
                        return
                    }
                    
                    print("response: \(response!)")
                    var data: String = String(data: data!, encoding: .utf8)!
                    print("data:\(data)")
                    //文字列の加工
                    data = data.replacingOccurrences(of: "[", with: "")
                    data = data.replacingOccurrences(of: "{\"id\":", with: "")
                    data = data.replacingOccurrences(of: "}", with: "")
                    data = data.replacingOccurrences(of: "]", with: "")
                    //配列にレスポンスデータを格納
                    self.appDelegate.cloth_array = data.components(separatedBy: ",")
                    print(self.appDelegate.cloth_array)
                    print(self.appDelegate.cloth_array.count)
                    self.completionHandler2()
                    
                })
                //タスクを開始する
                task.resume()
                
            }
        }
    }
    
    //通信が完了した後に実行する関数
    func completionHandler2(){
        DispatchQueue.main.async {
            
                
            var request = URLRequest(url: URL(string: "http://52.193.213.154:3000/api/v1/users/" + self.appDelegate.user_name)!)
            //HTTPメソッドを設定する
            request.httpMethod = "GET"
            //タスクを作成する
            let task = URLSession.shared.dataTask(with: request, completionHandler: {
                    (data, response, error) in
                    
                if error != nil {
                    print(error!)
                    return
                }
                    
                print("response: \(response!)")
                let data: String = String(data: data!, encoding: .utf8)!
                print("data:\(data)")
                let dataToConvert = data.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
                let json = JSON(data: dataToConvert!)
                print(json["sex"])
                print(json["birthday"])
                self.appDelegate.sex = json["sex"].intValue
                let birthday = json["birthday"].stringValue
                self.appDelegate.birthday = birthday.replacingOccurrences(of: "-", with: "/")
                self.region_id = json["region_id"].stringValue
                self.completionHandler3()
                })
                //タスクを開始する
                task.resume()
            
            
        }

        
    }
    
    
    func completionHandler3(){
        DispatchQueue.main.async {
            var request = URLRequest(url: URL(string: "http://52.193.213.154:3000/api/v1/region/" + self.region_id)!)
            //HTTPメソッドを設定する
            request.httpMethod = "GET"
            //タスクを作成する
            let task = URLSession.shared.dataTask(with: request, completionHandler: {
                (data, response, error) in
                
                if error != nil {
                    print(error!)
                    return
                }
                
                print("response: \(response!)")
                let data: String = String(data: data!, encoding: .utf8)!
                print("data:\(data)")
                let dataToConvert = data.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
                let json = JSON(data: dataToConvert!)
                print(json["region_name"])
                self.appDelegate.region = json["region_name"].stringValue
                self.completionHandler4()
            })
            //タスクを開始する
            task.resume()
        
        }
    }
    
    func completionHandler4(){
        
        DispatchQueue.main.async {
            // クルクルストップ
            self.ActivityIndicator.stopAnimating()
            let storyboard: UIStoryboard = self.storyboard!
            let nextView = storyboard.instantiateViewController(withIdentifier: "Home")
            self.present(nextView, animated: true, completion: nil)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
