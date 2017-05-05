//
//  FirstViewController.swift
//  Anetos
//
//  Created by 齋藤卓馬 on 2017/01/15.
//  Copyright © 2017年 齋藤卓馬. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UICollectionViewDataSource{
    
    var clothes:[Cloth] = [Cloth]()
    
    @IBOutlet weak var TopsCollectionView: UICollectionView!
    @IBOutlet weak var OthersCollectionView: UICollectionView!

    @IBOutlet weak var bottomsimage: UIImageView!
    
    //AppDelegateのインスタンスを取得
    var appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    func setupClothes() {
        //配列で取得したcloth_id分処理を繰り返す
        for cloth_id in self.appDelegate.cloth_array{
            let f = Cloth(imageUrl: NSURL(string: "http://52.193.213.154:3000/clothes/get_image?id=" + cloth_id))
            clothes.append(f)
        }
    }
    
    //データの個数を返すメソッド
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return clothes.count
    }
    

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == TopsCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopsCell", for: indexPath as IndexPath) as! HomeCollectionViewCell
//            セルの背景色をランダムに設定する。
                        cell.backgroundColor = UIColor(red: CGFloat(drand48()),
                                                       green: CGFloat(drand48()),
                                                       blue: CGFloat(drand48()),
                                                       alpha: 1.0)
                        cell.setCell(cloth: clothes[indexPath.row])
            
                        return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OthersCell", for: indexPath as IndexPath) as! HomeCollectionViewCell
            
            
                        cell.backgroundColor = UIColor(red: CGFloat(drand48()),
                                                        green: CGFloat(drand48()),
                                                        blue: CGFloat(drand48()),
                                                        alpha: 1.0)
            
            
                        cell.setCell2(cloth: clothes[indexPath.row])
                        return cell
        }
    }
    
    //データを返すメソッド
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
//    {
//        if indexPath.row == 0{
//            //コレクションビューから識別子「TestCell」のセルを取得する。
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopsCell", for: indexPath) as! HomeCollectionViewCell
//            
//            //セルの背景色をランダムに設定する。
//            cell.backgroundColor = UIColor(red: CGFloat(drand48()),
//                                           green: CGFloat(drand48()),
//                                           blue: CGFloat(drand48()),
//                                           alpha: 1.0)
//            cell.setCell(cloth: clothes[indexPath.row])
//
//            return cell
//
//        }
//        else {
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OthersCell", for: indexPath) as! HomeCollectionViewCell
//            
//            
//            cell.backgroundColor = UIColor(red: CGFloat(drand48()),
//                                            green: CGFloat(drand48()),
//                                            blue: CGFloat(drand48()),
//                                            alpha: 1.0)
//            
//            
//            cell.setCell2(cloth: clothes[indexPath.row])
//            return cell
//        }
//    }
 
    
     //ボトムスを表示させるメソッド
    func setupBottoms(){
        let imgUrl = NSURL(string: "http://52.193.213.154:3000/clothes/get_image?id=40");
        // ファイルデータを作る
        let file = NSData(contentsOf: imgUrl! as URL);
        // イメージデータを作る
        let img = UIImage(data:file! as Data)
        
        // イメージビューに表示する
        bottomsimage.image = img
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        TopsCollectionView.delegate = self
//        OthersCollectionView.delegate = self
        
        TopsCollectionView.dataSource = self
        OthersCollectionView.dataSource = self
        
        self.view.addSubview(TopsCollectionView)
        self.view.addSubview(OthersCollectionView)
        self.setupClothes()
        self.setupBottoms()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
