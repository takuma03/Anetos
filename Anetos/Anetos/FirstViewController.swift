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
    
    
    //データを返すメソッド
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        //コレクションビューから識別子「TestCell」のセルを取得する。
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TestCell", for: indexPath) as! HomeCollectionViewCell
        
        //セルの背景色をランダムに設定する。
        cell.backgroundColor = UIColor(red: CGFloat(drand48()),
                                       green: CGFloat(drand48()),
                                       blue: CGFloat(drand48()),
                                       alpha: 1.0)
        cell.setCell(cloth: clothes[indexPath.row])
        print(indexPath.row)
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.setupClothes()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

