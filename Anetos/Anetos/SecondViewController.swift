//
//  SecondViewController.swift
//  Anetos
//
//  Created by 齋藤卓馬 on 2017/01/15.
//  Copyright © 2017年 齋藤卓馬. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    
    var clothes:[Cloth] = [Cloth]()
    
    //レスポンスデータ格納用の配列定義
    var cloth_array: [String] = ["4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "38", "39", "40", "41", "42", "43", "44", "45", "46"]
    
    //TODO
    //ユーザ毎に一覧を表示させる必要がある
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //URLを設定する
        var request = URLRequest(url: URL(string: "http://52.196.123.118:3000/api/v1/clothes/takuma")!)
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
            self.cloth_array = data.components(separatedBy: ",")
            print(self.cloth_array)
            print(self.cloth_array.count)
            self.completionHandler()
            
        })
        //タスクを開始する
        //task.resume()
        print("test")
        self.setupClothes()

    }

    override func viewWillAppear(_ animated: Bool) {
       
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    
    }
    
    //通信が完了した後に実行する関数
    func completionHandler(){
        print("test0")
        print("test1")
        print(self.cloth_array)
    }
    
    func setupClothes() {
        
//        let f1 = Cloth(imageUrl: NSURL(string: "http://52.196.123.118:3000/clothes/get_image?id=7"))
//        let f2 = Cloth(imageUrl: NSURL(string: "http://52.196.123.118:3000/clothes/get_image?id=44"))
//        let f3 = Cloth(imageUrl: NSURL(string: "http://52.196.123.118:3000/clothes/get_image?id=46"))
//        clothes.append(f1)
//        clothes.append(f2)
//        clothes.append(f3)
//        print(clothes)
        
        //XXX
        //画像を毎回読み込んでいるためスクロールが重い
        for _ in cloth_array{
            let f = Cloth(imageUrl: NSURL(string: "http://52.196.123.118:3000/clothes/get_image?id=7"))
            clothes.append(f)
        }
    }
    
    // セクション数
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    // セクションの行数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return clothes.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath:IndexPath) -> UITableViewCell {
        
        let cell: CustomTableViewCell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath as IndexPath) as! CustomTableViewCell
        

        cell.setCell(cloth: clothes[indexPath.row])
        
        return cell
    }
}

