//
//  ConfirmPictureViewController.swift
//  Anetos
//
//  Created by 齋藤卓馬 on 2017/06/18.
//  Copyright © 2017年 齋藤卓馬. All rights reserved.
//

import UIKit

class ConfirmPictureViewController: UIViewController,URLSessionTaskDelegate {
    
    
    //AppDelegateのインスタンスを取得
    var appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet weak var takedPicture: UIImageView!
    
    @IBAction func savePicture(_ sender: UIButton) {
        print("アップロード開始しました。")
        // アップロード先を指定する
        var request = URLRequest(url:URL(string:"http://52.193.213.154:3000/api/v1/clothes/")!)
        
        request.httpMethod = "POST"
        // Content-Typeとして、multipart/form-dataを明示する、その中のboundary(境界線)の指定も必須
        let boundary = UUID().uuidString
        request.addValue("multipart/form-data; boundary=\"\(boundary)\"", forHTTPHeaderField: "Content-Type")
        
        // 画像データを読み出し、Data型に変換する.
        let file = UIImagePNGRepresentation(self.appDelegate.picture)!
        
        //POSTするデータを設定する
        var postData = Data()
        //画像データ用のパートデータを追加する
        postData.append("--\(boundary)\r\n".data(using: .utf8)!) //パートの境界線、先頭にも必要
        postData.append("Content-Disposition: form-data; name=\"photo\"; filename=\"test.PNG\"\r\n".data(using: .utf8)!) //パートヘッダーとしてContent-Dispositionと
        postData.append("Content-Type: image/png\r\n".data(using: .utf8)!) //Content-Typeを指定する
        postData.append("\r\n".data(using: .utf8)!) //空行がパートヘッダーとパートボディの境界線
        postData.append(file) //パートボディとして画像をData化したものを追加する
        postData.append("\r\n".data(using: .utf8)!) //パートボディの終了
        
        //文字データ(user_id)用のパートを追加する
        postData.append("--\(boundary)\r\n".data(using: .utf8)!) //パートの境界線
        postData.append("Content-Disposition: form-data; name=\"user_name\"\"\r\n".data(using: .utf8)!) //文字データの送信の場合(普通は)Content-Typeはなくてもサーバは受信してくれる
        postData.append("\r\n".data(using: .utf8)!) //空行がパートヘッダーとパートボディの境界線
        postData.append(self.appDelegate.user_name.data(using: .utf8)!) //パートボディとしてテキストをData化したものを追加する
        postData.append("\r\n".data(using: .utf8)!) //パートボディの終了
        
        //文字データ(tag_id)用のパートを追加する
        postData.append("--\(boundary)\r\n".data(using: .utf8)!) //パートの境界線
        postData.append("Content-Disposition: form-data; name=\"tag_name\"\"\r\n".data(using: .utf8)!)
        postData.append("\r\n".data(using: .utf8)!) //空行がパートヘッダーとパートボディの境界線
        postData.append(self.appDelegate.tag_name.data(using: .utf8)!) //パートボディとしてテキストをData化したものを追加する
        postData.append("\r\n".data(using: .utf8)!) //パートボディの終了
        
        //全パートの終了を示す
        postData.append("--\(boundary)--".data(using: .utf8)!) // end of all parts
        
        request.httpBody = postData
        
        
        //タスクを作成する
        let task = URLSession.shared.dataTask(with: request, completionHandler: {
            (data, response, error) in
            
            if error != nil {
                print(error!)
                return
            }
            //TBD
            //レスポンスを表示させると処理が重くなるためコメントアウト
            //print("response: \(response!)")
            
            self.appDelegate.token = String(data: data!, encoding: .utf8)!
            self.completionHandler()
            
        })
        //タスクを開始する
        print("通信を開始しました。")
        task.resume()
        
        //カメラ画面から戻る処理
        dismiss(animated: true, completion: nil)
        
        
        
    }
    
    
    //通信が完了した後に実行する関数
    func completionHandler(){
        // バックグラウンドだとUIの処理が出来ないので、メインスレッドでUIの処理を行わせる.
        DispatchQueue.main.async {
            //print("data: \(self.appDelegate.token)")
            if (self.appDelegate.token.contains("error")) {
                print("ログインエラー")
            } else {
                
                // ① UIAlertControllerクラスのインスタンスを生成
                // タイトル, メッセージ, Alertのスタイルを指定する
                // 第3引数のpreferredStyleでアラートの表示スタイルを指定する
                let alert: UIAlertController = UIAlertController(title: "保存完了", message: "保存しました。", preferredStyle:  UIAlertControllerStyle.alert)
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
                
                
                
                let storyboard: UIStoryboard = self.storyboard!
                let nextView = storyboard.instantiateViewController(withIdentifier: "Home")
                self.present(nextView, animated: true, completion: nil)
            }
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        takedPicture.image = self.appDelegate.picture
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
