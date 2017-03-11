//
//  LoginViewController.swift
//  Anetos
//
//  Created by 齋藤卓馬 on 2017/01/16.
//  Copyright © 2017年 齋藤卓馬. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    //AppDelegateのインスタンスを取得
    var appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBAction func login(_ sender: Any) {
        //POSTするデータを設定する
        let postString = "user_name=\(username.text!)&password=\(password.text!)"
        //グローバル変数にユーザ名を格納
        self.appDelegate.user_name =  username.text!
        //URLを設定する
        var request = URLRequest(url: URL(string: "http://52.196.123.118:3000/api/v1/login/")!)
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
            let token_array = token_data.components(separatedBy: "\"token\":")
            let token = token_array[1].components(separatedBy: "\"")
            print(token[1])
            self.appDelegate.token = token[1]
            self.completionHandler1()
            
        })
        //タスクを開始する
        task.resume()
    }
    
    //通信が完了した後に実行する関数
    func completionHandler1(){
        // バックグラウンドだとUIの処理が出来ないので、メインスレッドでUIの処理を行わせる.
        DispatchQueue.main.async {
            print("data: \(self.appDelegate.token)")
            if (self.appDelegate.token.contains("error")) {
                print("ログインエラー")
            } else {
                
                var request = URLRequest(url: URL(string: "http://52.196.123.118:3000/api/v1/clothes/" + self.appDelegate.user_name)!)
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
                
                let storyboard: UIStoryboard = self.storyboard!
                let nextView = storyboard.instantiateViewController(withIdentifier: "Home")
                self.present(nextView, animated: true, completion: nil)
            }
        }
    }
    
    //通信が完了した後に実行する関数
    func completionHandler2(){
        print("test0")
        print("test1")
        print(self.appDelegate.cloth_array)
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
