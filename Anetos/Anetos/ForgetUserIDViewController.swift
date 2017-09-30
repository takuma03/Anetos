//
//  ForgetUserIDViewController.swift
//  Anetos
//
//  Created by 齋藤卓馬 on 2017/09/03.
//  Copyright © 2017年 齋藤卓馬. All rights reserved.
//

import UIKit

class ForgetUserIDViewController: UIViewController {
    
    @IBOutlet weak var messageLabel: UILabel!
    
    @IBOutlet weak var mail: UITextField!
    
    // ActivityIndicator を用意
    var ActivityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        messageLabel.numberOfLines = 4
        messageLabel.text = "ユーザー IDをお忘れの方は登録されているメールアドレスを入力してください。ユーザーIDを登録されているメールアドレスに送信いたします。"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //ユーザーIDを忘れた際にメールを送信する処理
    @IBAction func sendMail(_ sender: UIButton) {
        //POSTするデータを設定する
        let postString = "mail=\(mail.text!)"
        //URLを設定する
        var request = URLRequest(url: URL(string: "http://52.193.213.154:3000/api/v1/userid/")!)
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
            // ① UIAlertControllerクラスのインスタンスを生成
            // タイトル, メッセージ, Alertのスタイルを指定する
            // 第3引数のpreferredStyleでアラートの表示スタイルを指定する
            let alert: UIAlertController = UIAlertController(title: "お知らせ   ", message: "メールを送信しました。", preferredStyle:  UIAlertControllerStyle.alert)
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
    
}
