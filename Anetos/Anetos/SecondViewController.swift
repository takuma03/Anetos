//
//  SecondViewController.swift
//  Anetos
//
//  Created by 齋藤卓馬 on 2017/01/15.
//  Copyright © 2017年 齋藤卓馬. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    @IBOutlet weak var closetTableView: UITableView!
    @IBOutlet weak var listButton: UIButton!
    @IBOutlet weak var tagButton: UIButton!
    @IBOutlet weak var registerDateButton: UIButton!
    //AppDelegateのインスタンスを取得
    var appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var clothes:[Cloth2] = [Cloth2]()
    var tag_clothes = [[Cloth2]]()
    var register_date_clothes = [[Cloth2]]()
    
    var tagList = [String]()
    var registerDateList = [String]()
    
    //ボタンフラグ
    //0:一覧(初期値)
    //1:タグ別
    //2:登録日別
    var frag = 0
    
    // ActivityIndicator を用意
    var ActivityIndicator: UIActivityIndicatorView!
    
    //選択されたcloth_id格納用変数定義
    var selectedId: String = ""
    
    
    @IBAction func unwindToCloset(segue: UIStoryboardSegue){
        
    }
    
    //ユーザ毎に一覧を表示
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        listButton.layer.borderWidth = 2.0 // 枠線の幅
        listButton.layer.borderColor = UIColor.orange.cgColor // 枠線の色
        tagButton.layer.borderWidth = 2.0 // 枠線の幅
        tagButton.layer.borderColor = UIColor.orange.cgColor // 枠線の色
        registerDateButton.layer.borderWidth = 2.0 // 枠線の幅
        registerDateButton.layer.borderColor = UIColor.orange.cgColor // 枠線の色
        self.setupClothes()
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupClothes() {
        //配列で取得したcloth_id分処理を繰り返す
        //配列が空の場合は処理させない
        if self.appDelegate.cloth_array.isEmpty {

        }else {
            var i = 0
            for cloth_id in self.appDelegate.cloth_array{
                let f = Cloth2(imageUrl: NSURL(string: "http://52.193.213.154:3000/clothes/get_image?id=" + cloth_id),id: self.appDelegate.cloth_array[i], tag: self.appDelegate.tag_list[self.appDelegate.tag_id_array[i]]! ,register_date: self.appDelegate.register_date_array[i])
                clothes.append(f)
                i = i + 1
            }
        }
    }
    
    // セクション数
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    //セクション名を返す
    func tableView(_ tableView:UITableView, titleForHeaderInSection section:Int) -> String?{
        if frag == 0 {
            return ""
        } else if frag == 1 {
            return tagList[section]
        } else {
            return registerDateList[section]
        }
    }
    
    //セクションの個数を返す
    func numberOfSections(in tableView: UITableView) -> Int {
        if frag == 0 {
            return 1
        } else if frag == 1 {
            return tagList.count
        } else {
            return registerDateList.count
        }
    }
    
    
    // セクションの行数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if frag == 0 {
            return clothes.count
        } else if frag == 1 {
            return tag_clothes[section].count
        } else {
            return register_date_clothes[section].count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath:IndexPath) -> UITableViewCell {
        if frag == 0 {
            let cell: CustomTableViewCell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath as IndexPath) as! CustomTableViewCell
            cell.setCell2(cloth: clothes[indexPath.row])
            print(indexPath.row)
            print(cell)
            return cell
        } else if frag == 1 {
            let cell: CustomTableViewCell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath as IndexPath) as! CustomTableViewCell
            cell.setCell2(cloth: tag_clothes[indexPath.section][indexPath.row])
            print(indexPath.row)
            print(cell)
            return cell
        } else {
            let cell: CustomTableViewCell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath as IndexPath) as! CustomTableViewCell
            cell.setCell2(cloth: register_date_clothes[indexPath.section][indexPath.row])
            print(indexPath.row)
            print(cell)
            return cell
        }
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
    
    //一覧ボタン押下時の処理
    @IBAction func listButton(_ sender: UIButton) {
        frag = 0
        print(clothes.count)
        self.closetTableView.reloadData()
        
    }
    //タグ別ボタン押下時の処理
    @IBAction func tagButton(_ sender: UIButton) {
        frag = 1
    
        var tempList = [String]()
        
        for tag in clothes {
            tempList.append(tag.tag)
        }
        
        let orderedSet:NSOrderedSet = NSOrderedSet(array: tempList)
        tagList = orderedSet.array as! [String]
        print("tagList表示")
        print(tagList)
        
        //tag_clothes配列が空の場合に洋服追加
        if tag_clothes.isEmpty {
            var i = 0
            for tag in tagList {
                for cloth in clothes{
                    if tag == cloth.tag{
                        tag_clothes.append([Cloth2]())
                        tag_clothes[i].append(cloth)
                    }
                }
                i = i + 1
            }
        }
        
        
        print("clothes表示")
        dump(clothes)
        print("tag_clothes表示")
        dump(tag_clothes)
        print(type(of: tag_clothes))
        self.closetTableView.reloadData()
    }
    //登録日ボタン押下時の処理
    @IBAction func registerDateButton(_ sender: UIButton) {
        frag = 2
        var tempList = [String]()
        
        for registerDate in clothes {
            tempList.append(registerDate.register_date)
        }
        print("tempList表示")
        print(tempList)
        
        
        let orderedSet:NSOrderedSet = NSOrderedSet(array: tempList)
        registerDateList = orderedSet.array as! [String]
        print("registerDateList表示")
        print(registerDateList)
        
        //register_date_clothes配列が空だった場合に洋服追加
        if register_date_clothes.isEmpty{
            var i = 0
            for registerDate in registerDateList {
                for cloth in clothes{
                    if registerDate == cloth.register_date{
                        register_date_clothes.append([Cloth2]())
                        register_date_clothes[i].append(cloth)
                    }
                }
                i = i + 1
            }
        }
        
        
        print("clothes表示")
        dump(clothes)
        print("register_date_clothes表示")
        dump(register_date_clothes)
        
        self.closetTableView.reloadData()
    }

    
}

