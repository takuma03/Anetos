//
//  LoginViewController.swift
//  Anetos
//
//  Created by 齋藤卓馬 on 2017/01/16.
//  Copyright © 2017年 齋藤卓馬. All rights reserved.
//

import UIKit
import SwiftyJSON

class LoginViewController: UIViewController {
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
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
            print(token_data)
            let token_array = token_data.components(separatedBy: "\"token\":")
            let token = token_array[1].components(separatedBy: "\"")
            print(token[1])
            self.appDelegate.token = token[1]
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
        // クルクルストップ
        ActivityIndicator.stopAnimating()
        // バックグラウンドだとUIの処理が出来ないので、メインスレッドでUIの処理を行わせる.
        DispatchQueue.main.async {
            print("data: \(self.appDelegate.token)")
            if (self.appDelegate.token.contains("error")) {
                print("ログインエラー")
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
                self.appDelegate.birthday = json["birthday"].stringValue
                
                
                //文字列の加工
                //data = data.replacingOccurrences(of: "{", with: "")
//                data = data.replacingOccurrences(of: "{\"id\":", with: "")
//                data = data.replacingOccurrences(of: "}", with: "")
//                data = data.replacingOccurrences(of: "]", with: "")
                //配列にレスポンスデータを格納
//                print(data)
//                let json = JSON(data: data!)
//                self.appDelegate.cloth_array = data.components(separatedBy: ",")
//                print(self.appDelegate.cloth_array)
//                print(self.appDelegate.cloth_array.count)
                
                })
                //タスクを開始する
                task.resume()
                
                let storyboard: UIStoryboard = self.storyboard!
                let nextView = storyboard.instantiateViewController(withIdentifier: "Home")
                self.present(nextView, animated: true, completion: nil)
            
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
