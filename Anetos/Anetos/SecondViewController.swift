//
//  SecondViewController.swift
//  Anetos
//
//  Created by 齋藤卓馬 on 2017/01/15.
//  Copyright © 2017年 齋藤卓馬. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    //AppDelegateのインスタンスを取得
    var appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var clothes:[Cloth] = [Cloth]()
    
    //選択されたcloth_id格納用変数定義
    var selectedId: String = ""
    
    @IBAction func unwindToCloset(segue: UIStoryboardSegue){
        
    }
    
    //ユーザ毎に一覧を表示
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func viewWillAppear(_ animated: Bool) {
        self.setupClothes()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupClothes() {
        //配列で取得したcloth_id分処理を繰り返す
        for cloth_id in self.appDelegate.cloth_array{
            let f = Cloth(imageUrl: NSURL(string: "http://52.196.123.118:3000/clothes/get_image?id=" + cloth_id))
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
    
    // Cell が選択された場合
    func tableView(_ table: UITableView,didSelectRowAt indexPath: IndexPath) {
        // EditCellViewController へ遷移するために Segue を呼び出す
        print(self.appDelegate.cloth_array[indexPath.row])
        selectedId = self.appDelegate.cloth_array[indexPath.row]
        performSegue(withIdentifier: "toEditCellViewController",sender: nil)
    }
    
    // Segue 準備
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        if (segue.identifier == "toEditCellViewController") {
            let EditCellVC: EditCellViewController = (segue.destination as? EditCellViewController)!
            EditCellVC.selectedID = selectedId
        }
    }
    
}

