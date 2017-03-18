//
//  EditCellViewController.swift
//  Anetos
//
//  Created by 齋藤卓馬 on 2017/02/26.
//  Copyright © 2017年 齋藤卓馬. All rights reserved.
//

import Foundation

class EditCellViewController: UIViewController {
    
    
    // ActivityIndicator を用意
    var ActivityIndicator: UIActivityIndicatorView!
    //AppDelegateのインスタンスを取得
    var appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet weak var selectCloth: UIImageView!
    var selectedID: String!
    
    //TODO
    //削除ボタンを押下したときの処理
    @IBAction func deleteCloth(_ sender: Any) {
        print("削除しました。")
        //POSTするデータを設定する
        let postString = "user_name=\(self.appDelegate.user_name)&token=\(self.appDelegate.token)&cloth_id=\(selectedID!)"
        print("POSTするデータを表示する")
        print(postString)
        //URLを設定する
        var request = URLRequest(url: URL(string: "http://52.193.213.154:3000/api/v1/delete/")!)
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
            //let data: String = String(data: data!, encoding: .utf8)!
            //print(data)
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
        print("削除通信が完了しました。")
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
    
    func completionHandler2(){
        print("削除後のデータ取得が完了しました。")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        selectCloth.sd_setImage(with: URL(string: "http://52.193.213.154:3000/clothes/get_image?id=" + selectedID))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
