//
//  ChoiceOthersController.swift
//  Anetos
//
//  Created by 桜井貴幸 on 2017/03/25.
//  Copyright © 2017年 齋藤卓馬. All rights reserved.
//

import UIKit

class ChoiceOthersViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate ,URLSessionTaskDelegate{
    
    @IBAction func goNext(_ sender: Any) {
        print(self.appDelegate.tag_name)
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.delegate = self
        present(picker, animated: true, completion: nil)
    }
    
    
    @IBOutlet weak var othersPicker: UIPickerView!
    
    
    //AppDelegateのインスタンスを取得
    var appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    
    var list = ["靴下（ショート）","靴下（ロング）","ストッキング","タイツ","スニーカー","革靴","ブーツ（ショート）","ブーツ（ロング）","サンダル","パンプス","マフラー","ストール","手袋","帽子","傘","その他"]
    
    //PickerViewに表示する列数を返す
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    //PickerViewに表示する行数を返す
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return list.count
    }
    //Picker Viewに表示する値を返す
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return list[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        // FIXME
        // 選択したデータをグローバル変数に渡せていない気がする
        self.appDelegate.tag_name = "\(list[row])"
    }
    
    //撮影が完了し、「Use Photo」が押されたときに呼ばれる
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print(#function)
        // print(info[UIImagePickerControllerMediaType]!)
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        // TBD
        // 撮影した画像をカメラロールに保存
        //UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        
        // 画像をアップロード機能
        print("アップロードを開始しました。")
        // アップロード先を指定する
        var request = URLRequest(url:URL(string:"http://52.193.213.154:3000/api/v1/clothes/")!)
        
        request.httpMethod = "POST"
        // Content-Typeとして、multipart/form-dataを明示する、その中のboundary(境界線)の指定も必須
        let boundary = UUID().uuidString
        request.addValue("multipart/form-data; boundary=\"\(boundary)\"", forHTTPHeaderField: "Content-Type")
        
        // 画像データを読み出し、Data型に変換する.
        let file = UIImagePNGRepresentation(image)!
        
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
        postData.append("Content-Disposition: form-data; name=\"user_id\"\"\r\n".data(using: .utf8)!) //文字データの送信の場合(普通は)Content-Typeはなくてもサーバは受信してくれる
        postData.append("\r\n".data(using: .utf8)!) //空行がパートヘッダーとパートボディの境界線
        postData.append("1".data(using: .utf8)!) //パートボディとしてテキストをData化したものを追加する
        postData.append("\r\n".data(using: .utf8)!) //パートボディの終了
        
        //文字データ(tag_id)用のパートを追加する
        postData.append("--\(boundary)\r\n".data(using: .utf8)!) //パートの境界線
        postData.append("Content-Disposition: form-data; name=\"tag_id\"\"\r\n".data(using: .utf8)!)
        postData.append("\r\n".data(using: .utf8)!) //空行がパートヘッダーとパートボディの境界線
        postData.append("1".data(using: .utf8)!) //パートボディとしてテキストをData化したものを追加する
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
    
    /*
     通信終了時に呼び出されるデリゲート.
     */
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        print("didCompleteWithError")
        
        // エラーが有る場合にはエラーのコードを取得.
        if error != nil {
            print(error!)
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
    
    //通信が完了した後に実行する関数
    func completionHandler(){
        // バックグラウンドだとUIの処理が出来ないので、メインスレッドでUIの処理を行わせる.
        DispatchQueue.main.async {
            print("data: \(self.appDelegate.token)")
            if (self.appDelegate.token.contains("error")) {
                print("ログインエラー")
            } else {
                let storyboard: UIStoryboard = self.storyboard!
                let nextView = storyboard.instantiateViewController(withIdentifier: "Home")
                self.present(nextView, animated: true, completion: nil)
            }
        }
    }
}
